//
//  MineKitPacketTests.swift
//  MineKitTests
//
//  Created by Conor Byrne on 03/05/2020.
//

import XCTest
import MineKit
import NIO

class MineKitPacketTests: XCTestCase {
    func testPacketCreation() throws {
        let buffer = ByteBuffer(ByteBufferView())
        XCTAssertNoThrow(try HandshakePacket(withHostname: "localhost", andPort: 25565).getBuffer(withBuffer: buffer))
    }
    
    func testInvalidPacketCreation() throws {
        let buffer = ByteBuffer(ByteBufferView())
        XCTAssertThrowsError(try HandshakePacket(withHostname: String(repeating: "A", count: 256), andPort: 00000).getBuffer(withBuffer: buffer))
    }
}
