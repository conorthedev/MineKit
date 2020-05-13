//
//  LoginPluginRequestHandler.swift
//  MineKit
//
//  Created by Conor Byrne on 13/05/2020.
//

import Foundation
import NIO
import Logging

public class LoginPluginResponsePacket : MineKitPacket {
    public var packetID: UInt8 = 0x02
    public var messageID: Int

    public func writeTo(buffer: inout MineKitBuffer) throws {
        buffer.writeVarInt(value: messageID)
        buffer.writeByte(value: 0x00)
    }
    
    init(messageID: Int) {
        self.messageID = messageID
    }
}

public class LoginPluginRequestHandler : MineKitRequestHandler {
    public var packetID: Int = 0x04
    
    public func handle(context: ChannelHandlerContext, packet: MineKitPacket) -> RequestHandlerResp {
        // This is the encryption packet ( we can assume ) so we just cast to LoginPluginRequestPacket
        let castedPacket = packet as! LoginPluginRequestPacket
        
        do {
            context.writeAndFlush(NIOAny(LoginPluginResponsePacket(messageID: castedPacket.messageID)))
            return .success
        }
    }
}
