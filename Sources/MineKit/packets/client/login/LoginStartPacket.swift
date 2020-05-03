//
//  LoginStartPacket.swift
//  MineKit
//
//  Created by Conor Byrne on 03/05/2020.
//

import Foundation
import NIO

public class LoginStartPacket : MineKitPacket {
    private let username: String

    public init(withUsername: String) {
        self.username = withUsername
    }

    public func getBuffer(withBuffer: ByteBuffer) throws -> ByteBuffer {
        var mkBuffer = MineKitBuffer(withByteBuffer: withBuffer)

        // Header
        mkBuffer.writeBytes(bytes: [UInt8(username.count + 2), 0x00])
        // Username
        try mkBuffer.writeString(value: username, max: 16)
        
        return mkBuffer.getBuffer()
    }
}

