//
//  MineKitBuffer.swift
//  MineKit
//
//  Created by Conor Byrne on 03/05/2020.
//

import Foundation
import NIO

enum MineKitBufferError: Error {
    case writeError(String)
    case readError(String)
}

public struct MineKitBuffer {
    public var buffer: ByteBuffer
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
        let byte = buffer.readInteger(endianness: Endianness.big, as: UInt8.self)
        return byte ?? 0
    }

    public mutating func readSignedByte() -> Int8 {
        let byte = buffer.readInteger(endianness: Endianness.big, as: Int8.self)
        return byte ?? 0
    }

    public mutating func readShort() -> UInt16 {
        let value = buffer.readInteger(endianness: Endianness.big, as: UInt16.self)
        return value ?? 0
    }

    public mutating func writeSignedByte(value: Int8) {
        buffer.writeInteger(value, endianness: Endianness.big)
    }

    public mutating func readSignedShort() -> Int16 {
        let byte = buffer.readInteger(endianness: Endianness.big, as: Int16.self)
        return byte ?? 0
    }

    public mutating func writeSignedShort(value: Int16) {
        buffer.writeInteger(value, endianness: Endianness.big)
    }

    public mutating func readSignedInt() -> Int32 {
        let byte = buffer.readInteger(endianness: Endianness.big, as: Int32.self)
        return byte ?? 0
    }

    public mutating func writeSignedInt(value: Int32) {
        buffer.writeInteger(value, endianness: Endianness.big)
    }

    public mutating func readSignedLong() -> Int64 {
        let byte = buffer.readInteger(endianness: Endianness.big, as: Int64.self)
        return byte ?? 0
    }

    public mutating func writeSignedLong(value: Int64) {
        buffer.writeInteger(value, endianness: Endianness.big)
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
            result = result | (value << (7 * numRead))
            numRead += 1
            if(numRead > 5) {
                throw MineKitBufferError.readError("VarInt too large!")
            }
        } while((read & 0b10000000) != 0)
        return result
    }
    
    public mutating func readString() throws -> String {
        let stringLength = try self.readVarInt()
        return buffer.readString(length: stringLength)!
    }
    
    public mutating func writeString(value: String, max: Int) throws {
        if(value.count > max) {
            throw MineKitBufferError.writeError("String length larger than expected! | Got \(value.count), expected \(max)")
        }
        let bytes = value.utf8.map{UInt8($0)}
        writeVarInt(value: bytes.count)
        writeBytes(bytes: bytes)
    }
    
    public mutating func writeUShort(value: Int) {
        writeShort(value: value)
    }
    
    public mutating func writeShort(value: Int) {
        buffer.writeInteger(Int16(value), endianness: Endianness.big)
    }

    public mutating func writeFloat(value: Float32) {
        buffer.writeInteger(value.bitPattern, endianness: Endianness.big)
    }

    public mutating func readFloat() -> Float32 {
        return Float32(bitPattern: UInt32(bigEndian: fromByteArray(buffer.readBytes(length: 4)!, UInt32.self)))
    }

    public mutating func writeDouble(value: Float64) {
        buffer.writeInteger(value.bitPattern, endianness: Endianness.big)
    }

    public mutating func readDouble() -> Float64 {
        return Float64(bitPattern: UInt64(bigEndian: fromByteArray(buffer.readBytes(length: 8)!, UInt64.self)))
    }

    public mutating func writeNBT(tag: NBTTag) {
        tag.writeTo(buffer: &self)
    }

    public mutating func readNBT() throws -> NBTTag {
        return try NBTTags.read(tagId: readByte(), buffer: &self)
    }
}
