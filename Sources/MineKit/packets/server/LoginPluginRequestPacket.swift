//
//  LoginPluginRequestPacket.swift
//  MineKit
//
//  Created by Conor Byrne on 13/05/2020.
//

import Foundation
import NIO

public class LoginPluginRequestPacket : MineKitPacket {
    public var packetID: UInt8 = 0x04
    public var messageID: Int
    public var channel: String
    public var data: [UInt8]
    
    public func writeTo(buffer: inout MineKitBuffer) throws {
        throw MineKitBufferError.writeError("Unable to write LoginPluginRequestPacket to buffer: Not implemented")
    }
    
    init(messageID: Int, channel: String, data: [UInt8]) {
        self.messageID = messageID
        self.channel = channel
        self.data = data
    }
}
