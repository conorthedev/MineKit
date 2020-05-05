//
//  ServerDifficultyReader.swift
//  MineKit
//
//  Created by Conor Byrne on 05/05/2020.
//

import Foundation
import NIO

public class ServerDifficultyReader : MineKitPacketReader {
    public var packetID: Int = 0x0E
    public var packetDirection: PacketDirection = .CLIENT
    public var connectionState: ConnectionState = .PLAY
    
    public func toPacket(fromBuffer: inout MineKitBuffer) throws -> MineKitPacket {
        var mutableBuffer = fromBuffer
        let difficulty = mutableBuffer.readByte()
        let isLocked = mutableBuffer.readByte() != 0
        fromBuffer = mutableBuffer
        
        return ServerDifficultyPacket(difficulty: difficulty, isLocked: isLocked)
    }
}
