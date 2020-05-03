//
//  LoginStartPacket.swift
//  MineKit
//
//  Created by Conor Byrne on 03/05/2020.
//

import Foundation
import NIO

public class LoginStartPacket : MineKitPacket {
    public var packetID: UInt8 = 0x00

    private let username: String

    public init(withUsername: String) {
        self.username = withUsername
    }

    public func writeTo(buffer: inout MineKitBuffer) throws {
        // Username
        try buffer.writeString(value: username, max: 16)
    }
}

