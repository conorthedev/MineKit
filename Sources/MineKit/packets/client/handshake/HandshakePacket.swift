//
//  HandshakePacket.swift
//  MineKit
//
//  Created by Conor Byrne on 03/05/2020.
//

import Foundation
import NIO

public class HandshakePacket : MineKitPacket {
    private let hostname: String
    private let port: Int
    
    public init(withHostname: String, andPort: Int) {
        self.hostname = withHostname
        self.port = andPort
    }
    
    public func getBuffer(withBuffer: ByteBuffer) throws -> ByteBuffer {
        var mkBuffer = MineKitBuffer(withByteBuffer: withBuffer)

        // Header
        mkBuffer.writeBytes(bytes: [0x10, 0x00])
        // Protocol Version
        mkBuffer.writeVarInt(value: MineKitProtocolVersion.v1_15_2)
        // Hostname
        try mkBuffer.writeString(value: hostname, max: 255)
        // Port
        mkBuffer.writeUShort(value: port)
        // Next state
        mkBuffer.writeVarInt(value: 2)
        
        return mkBuffer.getBuffer()
    }
}
