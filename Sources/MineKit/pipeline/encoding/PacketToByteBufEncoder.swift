//
//  PacketToByteBufEncoder.swift
//  CNIOAtomics
//
//  Created by Conor Byrne on 03/05/2020.
//

import Foundation
import NIO

final class PacketToByteBufEncoder : MessageToByteEncoder {
    typealias OutboundIn = MineKitPacket
    
    func encode(data: MineKitPacket, out: inout ByteBuffer) throws {
        MineKitCoderUtils.writeVarInt(withValue: Int(data.packetID), toBuffer: &out)
        var mkBuffer = MineKitBuffer(withByteBuffer: out)
        try data.writeTo(buffer: &mkBuffer)
        out = mkBuffer.getBuffer()
    }
}
