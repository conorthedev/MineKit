//
//  LoginPluginReqReader.swift
//  MineKit
//
//  Created by Conor Byrne on 13/05/2020.
//

import Foundation
import NIO
import Logging

public class LoginPluginReqReader : MineKitPacketReader {
    public var packetID: Int = 0x04
    public var packetDirection: PacketDirection = .CLIENT
    public var connectionState: ConnectionState = .PLAY
    private var reqPacket: LoginPluginRequestPacket? = nil
    
    public func toPacket(fromBuffer: inout MineKitBuffer) throws -> MineKitPacket {
        var mutableBuffer = fromBuffer
        let messageID = try mutableBuffer.readVarInt()
        let channel = try mutableBuffer.readString()
        let data = mutableBuffer.buffer.readBytes(length: mutableBuffer.buffer.readableBytes)
        fromBuffer = mutableBuffer
        
        reqPacket = LoginPluginRequestPacket(messageID: messageID, channel: channel, data: data!)
        return reqPacket!
    }

}
