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
    case readError(String)
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
    
    public mutating func readByte() -> UInt8 {
        let byte = buffer.getInteger(at: buffer.readerIndex, endianness: Endianness.big, as: UInt8.self)
        buffer.moveReaderIndex(forwardBy: 1)
        return byte ?? 0
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
    
    public mutating func readVarInt() throws -> Int {
        var numRead = 0
        var result = 0
        var read: Int = 0
        repeat {
            read = Int(readByte())
            let value = read & 0b01111111
            result = result | (value >> (7 * numRead))
            numRead += 1
            if(numRead > 5 || numRead > buffer.readableBytes) {
                throw MKBufferError.readError("VarInt too large!")
            }
        } while((read & 0b10000000) != 0)
        return result
    }
    
    /*
     override fun readVarInt(): Int {
        var numRead = 0
        var result = 0
        var read: Int
        do {
            read = readByte().toInt()
            val value = read and 0b01111111
            result = result or (value shl (7 * numRead))
            numRead++
            if (numRead > 5) error("VarInt too big")
        } while ((read and 0b10000000) != 0)
        return result
    }
     */
    
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
