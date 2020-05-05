//
//  PlayerInfoReader.swift
//  MineKit
//
//  Created by Conor Byrne on 05/05/2020.
//

import Foundation
import NIO

public class PlayerInfoReader : MineKitPacketReader {
    public var packetID: Int = 0x34
    public var packetDirection: PacketDirection = .CLIENT
    public var connectionState: ConnectionState = .PLAY
    
    public func toPacket(fromBuffer: inout MineKitBuffer) throws -> MineKitPacket {
        var mutableBuffer = fromBuffer
        fromBuffer = mutableBuffer
        
        return PlayerInfoPacket()
    }
}
