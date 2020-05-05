//
//  HeldItemChangePacket.swift
//  MineKit
//
//  Created by Conor Byrne on 05/05/2020.
//

import Foundation
import NIO

public class HeldItemChangePacket : MineKitPacket {
    public var packetID: UInt8 = 0x40
    public var slot: UInt8
    
    public func writeTo(buffer: inout MineKitBuffer) throws {
        throw MineKitBufferError.writeError("Unable to write HeldItemChangePacket to buffer: Not implemented")
    }
    
    init(slot: UInt8) {
        self.slot = slot
    }
}
