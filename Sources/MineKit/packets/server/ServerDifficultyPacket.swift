//
//  ServerDifficultyPacket.swift
//  MineKit
//
//  Created by Conor Byrne on 05/05/2020.
//

import Foundation
import NIO

public class ServerDifficultyPacket : MineKitPacket {
    public var packetID: UInt8 = 0x0E
    public var difficulty: UInt8 // 0: peaceful, 1: easy, 2: normal, 3: hard
    public var isLocked: Bool
    
    public func writeTo(buffer: inout MineKitBuffer) throws {
        throw MineKitBufferError.writeError("Unable to write ServerDifficultyPacket to buffer: Not implemented")
    }
    
    init(difficulty: UInt8, isLocked: Bool) {
        self.difficulty = difficulty
        self.isLocked = isLocked
    }
    
}
