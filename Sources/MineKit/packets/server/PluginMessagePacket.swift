//
//  PluginMessagePacket.swift
//  MineKit
//
//  Created by Conor Byrne on 05/05/2020.
//

import Foundation
import NIO

public class PluginMessagePacket : MineKitPacket {
    public var packetID: UInt8 = 0x19
    public var channel: String
    public var data: [UInt8]
    
    public func writeTo(buffer: inout MineKitBuffer) throws {
        throw MineKitBufferError.writeError("Unable to write PluginMessagePacket to buffer: Not implemented")
    }
    
    init(channel: String, data: [UInt8]) {
        self.channel = channel
        self.data = data
    }
}
