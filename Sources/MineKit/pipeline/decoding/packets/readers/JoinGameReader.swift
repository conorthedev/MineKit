//
//  JoinGameReader.swift
//  MineKit
//
//  Created by Conor Byrne on 05/05/2020.
//

import Foundation
import NIO

public class JoinGamePacket : MineKitPacket {
    public var packetID: UInt8 = 0x26
    
    public var entityID: Int32
    public var gamemode: UInt8
    public var dimension: Int32
    public var hashedSeed: Int64
    public var maxPlayers: UInt8
    public var levelType: String
    public var viewDistance: Int
    public var reducedDebug: Bool
    public var respawnScreen: Bool

    public func writeTo(buffer: inout MineKitBuffer) throws {
        // TODO: Writing to buffer
    }
    
    init(eid: Int32, gamemode: UInt8, dimension: Int32, hashedSeed: Int64, maxPlayers: UInt8, levelType: String, viewDistance: Int, reducedDebug: Bool, respawnScreen: Bool) {
        self.entityID = eid
        self.gamemode = gamemode
        self.dimension = dimension
        self.hashedSeed = hashedSeed
        self.maxPlayers = maxPlayers
        self.levelType = levelType
        self.viewDistance = viewDistance
        self.reducedDebug = reducedDebug
        self.respawnScreen = respawnScreen
    }
}


public class JoinGameReader : PacketReader {
    public var packetID: Int = 0x26
    public var packetDirection: PacketDirection = .SERVER
    public var connectionState: ConnectionState = .PLAY
    
    public func toPacket(fromBuffer: MineKitBuffer) throws -> MineKitPacket {
        var mutableBuffer = fromBuffer
        
        let eid = mutableBuffer.buffer.readInteger(endianness: .big, as: Int32.self)
        if(eid == nil) {
            throw MKBufferError.readError("Entity ID is nil!")
        }
                
        let gamemode = mutableBuffer.readByte()
        let dimension = mutableBuffer.buffer.readInteger(endianness: .big, as: Int32.self)
        if(dimension == nil) {
            throw MKBufferError.readError("Dimension is nil!")
        }
        let hashedSeed = mutableBuffer.buffer.readInteger(endianness: .big, as: Int64.self)
        if(eid == nil) {
            throw MKBufferError.readError("Hashed Seed is nil!")
        }
        let maxPlayers = mutableBuffer.readByte()
        let levelType = try mutableBuffer.readString()
        let viewDistance = try mutableBuffer.readVarInt()
        let reducedDebug = mutableBuffer.readByte() != 0
        let respawnScreen = mutableBuffer.readByte() != 0
        
        return JoinGamePacket(eid: eid!, gamemode: gamemode, dimension: dimension!, hashedSeed: hashedSeed!, maxPlayers: maxPlayers, levelType: levelType, viewDistance: viewDistance, reducedDebug: reducedDebug, respawnScreen: respawnScreen)
    }
}
