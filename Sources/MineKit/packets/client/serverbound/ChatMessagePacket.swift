//
//  ChatMessagePacket.swift
//  MineKit
//
//  Created by Conor Byrne on 03/05/2020.
//

import Foundation
import NIO

public class ChatMessagePacket : MineKitPacket {
    public var packetID: UInt8 = 0x03
    private let message: String

    public init(withMessage: String) {
        self.message = withMessage
    }

    public func writeTo(buffer: inout MineKitBuffer) throws {
        // Chat message
        try buffer.writeString(value: message, max: 256)
    }
}
