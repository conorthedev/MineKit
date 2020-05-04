//
//  ByteBufToPacketDecoder.swift
//  MineKit
//
//  Created by Conor Byrne on 03/05/2020.
//

import Foundation
import NIO

final class ByteBufToPacketDecoder : ByteToMessageDecoder {
    typealias InboundOut = MineKitPacket

    func decode(context: ChannelHandlerContext, buffer: inout ByteBuffer) throws -> DecodingState {
        var length = 0
        var packetID = 0
        
        // Make sure we're at the start of the buffer
        buffer.moveReaderIndex(to: 0)

        // Cast our buffer to MineKitBuffer and get the length (which is a VarInt like wtf minecraft use normal shit)
        var minekitBuf = MineKitBuffer(withByteBuffer: buffer)
        length = try minekitBuf.readVarInt()
        
        print("Packet length: \(length)")
        
        // Slice the buffer from the 2nd byte to the packet length
        var minekitSlicedBuf = MineKitBuffer(withByteBuffer: buffer.getSlice(at: 1, length: length)!)
        packetID = try minekitSlicedBuf.readVarInt()
        
        print("Packet ID: \(packetID)")

        return .needMoreData
    }
}
