//
//  PlayerInfoPacket.swift
//  MineKit
//
//  Created by Conor Byrne on 05/05/2020.
//

import Foundation
import NIO

public class PlayerInfoPacket : MineKitPacket {
    public var packetID: UInt8 = 0x34
    
    public func writeTo(buffer: inout MineKitBuffer) throws {
        throw MineKitBufferError.writeError("Cannot write PlayerInfoPacket to buffer: Not implemented")
    }
}
