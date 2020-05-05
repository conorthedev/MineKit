//
//  PluginMessageReader.swift
//  MineKit
//
//  Created by Conor Byrne on 05/05/2020.
//

import Foundation
import NIO

public class PluginMessageReader : MineKitPacketReader {
    public var packetID: Int = 0x19
    public var packetDirection: PacketDirection = .CLIENT
    public var connectionState: ConnectionState = .PLAY
    
    public func toPacket(fromBuffer: inout MineKitBuffer) throws -> MineKitPacket {
        var mutableBuffer = fromBuffer
        let channel = try mutableBuffer.readString()
        let data = mutableBuffer.buffer.readBytes(length: mutableBuffer.buffer.readableBytes)!

        fromBuffer = mutableBuffer
        
        return PluginMessagePacket(channel: channel, data: data)
    }
}
