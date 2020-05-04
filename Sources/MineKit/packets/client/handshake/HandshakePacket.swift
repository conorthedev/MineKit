//
//  HandshakePacket.swift
//  MineKit
//
//  Created by Conor Byrne on 03/05/2020.
//

import Foundation
import NIO

public class HandshakePacket : MineKitPacket {
    public var packetID: UInt8 = 0x00
    
    private let hostname: String
    private let port: Int
    
    public init(withHostname: String, andPort: Int) {
        self.hostname = withHostname
        self.port = andPort
    }
    
    public func writeTo(buffer: inout MineKitBuffer) throws {
        // Protocol Version
        buffer.writeVarInt(value: MineKitProtocolVersion.v1_15_2.rawValue)
        // Hostname
        try buffer.writeString(value: hostname, max: 255)
        // Port
        buffer.writeUShort(value: port)
        // Next state
        buffer.writeVarInt(value: 2)
    }
}
