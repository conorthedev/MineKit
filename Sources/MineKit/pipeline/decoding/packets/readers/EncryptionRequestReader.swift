//
//  EncryptionRequestReader.swift
//  MineKit
//
//  Created by Conor Byrne on 04/05/2020.
//

import Foundation
import NIO

public class EncryptionRequestPacket : MineKitPacket {
    var serverID: String
    var publicKeyLength: Int
    var publicKey: [UInt8]
    var verifyTokenLength: Int
    var verifyToken: [UInt8]

    public var packetID: UInt8 = 0x01
    
    public func writeTo(buffer: inout MineKitBuffer) throws {
        try buffer.writeString(value: serverID, max: 20)
        buffer.writeVarInt(value: publicKeyLength)
        buffer.writeBytes(bytes: publicKey)
        buffer.writeVarInt(value: verifyTokenLength)
        buffer.writeBytes(bytes: verifyToken)
    }
    
    init(serverID: String, publicKeyLength: Int, publicKey: [UInt8], tokenLength: Int, verifyToken: [UInt8]) {
        self.serverID = serverID
        self.publicKeyLength = publicKeyLength
        self.publicKey = publicKey
        self.verifyToken = verifyToken
        self.verifyTokenLength = tokenLength
    }
}

public class EncryptionRequestReader : PacketReader {
    public var packetID: Int = 0x01
    public var packetDirection: PacketDirection = .SERVER
    public var connectionState: ConnectionState = .LOGIN
    
    public func toPacket(fromBuffer: MineKitBuffer) throws -> MineKitPacket {
        var mutableBuffer = fromBuffer
        
        let serverID = try mutableBuffer.readString()
        let publicKeyLength = try mutableBuffer.readVarInt()
        let publicKey = mutableBuffer.buffer.readBytes(length: publicKeyLength)!
        let tokenLength = try mutableBuffer.readVarInt()
        let verifyToken = mutableBuffer.buffer.readBytes(length: tokenLength)!

        return EncryptionRequestPacket(serverID: serverID, publicKeyLength: publicKeyLength, publicKey: publicKey, tokenLength: tokenLength, verifyToken: verifyToken)
    }
}
