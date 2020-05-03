//
//  MineKitBuffer.swift
//  MineKit
//
//  Created by Conor Byrne on 03/05/2020.
//

import Foundation
import NIO

enum MKBufferError: Error {
    case writeError(String)
}

public struct MineKitBuffer {
    private var buffer: ByteBuffer
    public init(withByteBuffer: ByteBuffer) {
        buffer = withByteBuffer
    }
    
    public mutating func writeBytes(bytes: [UInt8]) {
        buffer.writeBytes(bytes)
    }
    
    public mutating func writeByte(value: Int) {
        buffer.writeBytes([UInt8(value)])
    }
    
    public mutating func writeVarInt(value: Int) {
        var toWrite = value
        repeat {
            var temp = (toWrite & 0b01111111)
            toWrite = toWrite >> 7
            if(toWrite != 0) {
                temp = (Int(temp) | 0b10000000)
            }
            self.writeByte(value: temp)
        } while (toWrite != 0)
    }
    
    public mutating func writeString(value: String, max: Int) throws {
        if(value.count > max) {
            throw MKBufferError.writeError("String length larger than expected! | Got \(value.count), expected \(max)")
        }
        let bytes = value.utf8.map{UInt8($0)}
        writeVarInt(value: bytes.count)
        writeBytes(bytes: bytes)
    }
    
    public mutating func writeUShort(value: Int) {
        writeShort(value: value)
    }
    
    public mutating func writeShort(value: Int) {
        buffer.writeInteger(Int16(value))
    }
    
    public func getBuffer() -> ByteBuffer {
        return buffer
    }
}
