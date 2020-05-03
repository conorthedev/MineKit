//
//  HandshakePacket.swift
//  MineKit
//
//  Created by Conor Byrne on 03/05/2020.
//

import Foundation
import NIO

class HandshakePacket : Packet {
    private let hostname: String
    private let port: Int
    
    init(withHostname: String, andPort: Int) {
        self.hostname = withHostname
        self.port = andPort
    }
    
    func getBuffer(withBuffer: ByteBuffer) -> ByteBuffer {
        var mkBuffer = MineKitBuffer(withByteBuffer: withBuffer)

        // Header
        mkBuffer.writeBytes(bytes: [0x10, 0x00])
        // Protocol Version
        mkBuffer.writeVarInt(value: MineKitProtocolVersion.v1_15_2)
        // Hostname
        mkBuffer.writeString(value: hostname, max: 255)
        // Port
        mkBuffer.writeUShort(value: port)
        // Next state
        mkBuffer.writeVarInt(value: 2)
        
        return mkBuffer.getBuffer()
    }
}
