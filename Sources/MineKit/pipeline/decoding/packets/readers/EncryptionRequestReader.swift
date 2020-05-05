//
//  EncryptionRequestReader.swift
//  MineKit
//
//  Created by Conor Byrne on 04/05/2020.
//

import Foundation
import NIO

public class EncryptionRequestReader : MineKitPacketReader {
    public var packetID: Int = 0x01
    public var packetDirection: PacketDirection = .SERVER
    public var connectionState: ConnectionState = .LOGIN
    
    public func toPacket(fromBuffer: inout MineKitBuffer) throws -> MineKitPacket {
        var mutableBuffer = fromBuffer
        
        let serverID = try mutableBuffer.readString()
        let publicKeyLength = try mutableBuffer.readVarInt()
        let publicKey = mutableBuffer.buffer.readBytes(length: publicKeyLength)!
        let tokenLength = try mutableBuffer.readVarInt()
        let verifyToken = mutableBuffer.buffer.readBytes(length: tokenLength)!
        
        fromBuffer = mutableBuffer

        return EncryptionRequestPacket(serverID: serverID, publicKeyLength: publicKeyLength, publicKey: publicKey, tokenLength: tokenLength, verifyToken: verifyToken)
    }
}

