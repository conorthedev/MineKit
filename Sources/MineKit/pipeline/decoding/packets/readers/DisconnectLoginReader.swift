//
//  DisconnectLoginReader.swift
//  MineKit
//
//  Created by Conor Byrne on 13/05/2020.
//

import Foundation
import NIO

public class DisconnectLoginReader : MineKitPacketReader {
    public var packetID: Int = 0x00
    public var packetDirection: PacketDirection = .CLIENT
    public var connectionState: ConnectionState = .LOGIN
    
    public func toPacket(fromBuffer: inout MineKitBuffer) throws -> MineKitPacket {
        var mutableBuffer = fromBuffer
        let reason = try mutableBuffer.readString()
        fromBuffer = mutableBuffer
        
        return DisconnectLoginPacket(reasonString: reason)
    }
}
