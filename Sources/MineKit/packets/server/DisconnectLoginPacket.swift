//
//  DisconnectLoginPacket.swift
//  MineKit
//
//  Created by Conor Byrne on 13/05/2020.
//

import Foundation
import NIO

public class DisconnectLoginPacket : MineKitPacket {
    public var packetID: UInt8 = 0x00
    public var reasonString: String
    
    public func writeTo(buffer: inout MineKitBuffer) throws {
        throw MineKitBufferError.writeError("Unable to write ServerListPingPacket to buffer: Not implemented")
    }
    
    init(reasonString: String) {
        self.reasonString = reasonString
        print(reasonString)
    }
}
