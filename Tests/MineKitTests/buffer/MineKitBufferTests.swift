//
//  MineKitBufferTests.swift
//  MineKitTests
//
//  Created by Conor Byrne on 03/05/2020.
//

import XCTest
import NIO
import MineKit

class MineKitBufferTests: XCTestCase {
    /*
     This test is verifying that the exception is thrown (see MKBufferError#writeError) when writing a string and you specify a max that is lower than the actual
     */
    func testWriteString() throws {
        var mineKitBuffer = MineKitBuffer(withByteBuffer: ByteBuffer(ByteBufferView()))
        // ConorDoesMC is 11 chars
        XCTAssertThrowsError(try mineKitBuffer.writeString(value: "ConorDoesMC", max: 10))
        XCTAssertNoThrow(try mineKitBuffer.writeString(value: "ConorDoesMC", max: 11))
    }
}
