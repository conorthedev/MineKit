//
//  ByteBufToPacketDecoder.swift
//  MineKit
//
//  Created by Conor Byrne on 03/05/2020.
//

import Foundation
import NIO

public enum MKPacketError : Error {
    case cannotParse(String)
}

final class ByteBufToPacketDecoder : ByteToMessageDecoder {
    typealias InboundOut = MineKitPacket
    var packetDecoderMap = [
        0x01: EncryptionRequestReader(),
        0x02: LoginSuccessReader(),
        0x03: SetCompressionReader(),
        0x26: JoinGameReader()
    ] as [Int : PacketReader]

    func decode(context: ChannelHandlerContext, buffer: inout ByteBuffer) throws -> DecodingState {
        buffer.moveReaderIndex(to: 0)
        
        //print(buffer.getBytes(at: 0, length: 4))
        
        if(buffer.readableBytes == 0) {
            return .needMoreData
        }

        // Cast our buffer to MineKitBuffer and get the length (which is a VarInt like wtf minecraft use normal shit)
        var minekitBuf = MineKitBuffer(withByteBuffer: buffer)
        let packetLength = try minekitBuf.readVarInt()

        if(buffer.readableBytes < packetLength) {
            return .needMoreData
        }
                
        // Slice the buffer from the byte after the varint to the packet length
        var minekitSlicedBuf = MineKitBuffer(withByteBuffer: minekitBuf.buffer.getSlice(at: minekitBuf.buffer.readerIndex, length: packetLength)!)
        let packetID = try minekitSlicedBuf.readVarInt()
        print("ℹ️ Parsing packet with ID 0x\(String(format:"%02X", packetID)) of length \(packetLength)")

        if(packetDecoderMap.contains(where: { (arg0) -> Bool in
            let (key, _) = arg0
            if(key == packetID) {
                return true
            } else {
                return false
            }
        })) {
            let packet = try packetDecoderMap[packetID]!.toPacket(fromBuffer: minekitSlicedBuf)

            context.fireChannelRead(NIOAny(packet))
            buffer.moveReaderIndex(forwardBy: buffer.readableBytes)
            return .needMoreData
        } else {
            throw MKPacketError.cannotParse("Unable to parse packet: 0x\(String(format:"%02X", packetID))")
        }
    }
}
