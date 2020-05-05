//
//  SetCompressionReader.swift
//  MineKit
//
//  Created by Conor Byrne on 04/05/2020.
//

import Foundation
import NIO

public class SetCompressionPacket : MineKitPacket {
    var threshold: Int
    public var packetID: UInt8 = 0x03
    
    public func writeTo(buffer: inout MineKitBuffer) throws {
        buffer.writeVarInt(value: threshold)
    }
    
    init(threshold: Int) {
        self.threshold = threshold
    }
}


public class SetCompressionReader : MineKitPacketReader {
    public var packetID: Int = 0x03
    public var packetDirection: PacketDirection = .SERVER
    public var connectionState: ConnectionState = .LOGIN
    
    public func toPacket(fromBuffer: inout MineKitBuffer) throws -> MineKitPacket {
        var mutableBuffer = fromBuffer
        let threshold = try mutableBuffer.readVarInt()
        
        fromBuffer = mutableBuffer
        
        return SetCompressionPacket(threshold: threshold)
    }
}

