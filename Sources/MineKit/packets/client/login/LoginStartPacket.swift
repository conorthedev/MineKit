//
//  LoginStartPacket.swift
//  MineKit
//
//  Created by Conor Byrne on 03/05/2020.
//

import Foundation
import NIO

class LoginStartPacket : Packet {
    private let username: String

    init(withUsername: String) {
        self.username = withUsername
    }

    func getBuffer(withBuffer: ByteBuffer) -> ByteBuffer {
        var mkBuffer = MineKitBuffer(withByteBuffer: withBuffer)

        // Header
        mkBuffer.writeBytes(bytes: [UInt8(username.count + 2), 0x00])
        // Username
        mkBuffer.writeString(value: username, max: 16)
        
        return mkBuffer.getBuffer()
    }
}
