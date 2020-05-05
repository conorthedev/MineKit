//
//  EncryptionRequestPacket.swift
//  MineKit
//
//  Created by Conor Byrne on 05/05/2020.
//

import Foundation
import NIO

public class EncryptionRequestPacket : MineKitPacket {
    public var serverID: String
    public var publicKeyLength: Int
    public var publicKey: [UInt8]
    public var verifyTokenLength: Int
    public var verifyToken: [UInt8]

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
