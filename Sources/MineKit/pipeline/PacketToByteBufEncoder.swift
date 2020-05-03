//
//  PacketToByteBufEncoder.swift
//  CNIOAtomics
//
//  Created by Conor Byrne on 03/05/2020.
//

import Foundation
import NIO

func writeByte(withValue: Int, toBuffer: inout ByteBuffer) {
    toBuffer.writeBytes([UInt8(withValue)])
}

func writeVarInt(withValue: Int, toBuffer: inout ByteBuffer) {
    var toWrite = withValue
    repeat {
        var temp = (toWrite & 0b01111111)
        toWrite = toWrite >> 7
        if(toWrite != 0) {
            temp = (Int(temp) | 0b10000000)
        }
        writeByte(withValue: temp, toBuffer: &toBuffer)
    } while (toWrite != 0)
}

final class PacketToByteBufEncoder : MessageToByteEncoder {
    typealias OutboundIn = MineKitPacket
    
    func encode(data: MineKitPacket, out: inout ByteBuffer) throws {
        writeVarInt(withValue: Int(data.packetID), toBuffer: &out)
        var mkBuffer = MineKitBuffer(withByteBuffer: out)
        try data.writeTo(buffer: &mkBuffer)
        out = mkBuffer.getBuffer()
    }
}

final class ByteBufferToLengthBufferEncoder : MessageToByteEncoder {
    typealias OutboundIn = ByteBuffer
    
    func encode(data: ByteBuffer, out: inout ByteBuffer) throws {
        writeVarInt(withValue: data.readableBytes, toBuffer: &out)
        var varData = data
        out.writeBuffer(&varData)
    }
}
