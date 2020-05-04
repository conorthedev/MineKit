//
//  LoginSuccessReader.swift
//  MineKit
//
//  Created by Conor Byrne on 04/05/2020.
//

import Foundation
import NIO

public class LoginSuccessPacket : MineKitPacket {
    var uuid: String
    var username: String

    public var packetID: UInt8 = 0x02
    
    public func writeTo(buffer: inout MineKitBuffer) throws {
        try buffer.writeString(value: uuid, max: 36)
        try buffer.writeString(value: username, max: 16)
    }
    
    init(username: String, uuid: String) {
        self.username = username
        self.uuid = uuid
    }
}


public class LoginSuccessReader : PacketReader {
    public var packetID: Int = 0x02
    public var packetDirection: PacketDirection = .SERVER
    public var connectionState: ConnectionState = .LOGIN
    
    public func toPacket(fromBuffer: MineKitBuffer) throws -> MineKitPacket {
        var mutableBuffer = fromBuffer
        
        let uuid = try mutableBuffer.readString()
        let username = try mutableBuffer.readString()
        
        print("🐛 [LoginSuccessReader]: Username: \(username) | UUID: \(uuid)")
        
        return LoginSuccessPacket(username: username, uuid: uuid)
    }
}
