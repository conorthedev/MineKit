//
//  PlayerAbilitiesReader.swift
//  MineKit
//
//  Created by Conor Byrne on 05/05/2020.
//

import Foundation
import NIO

func fromByteArray<T>(_ value: [UInt8], _: T.Type) -> T {
    return value.withUnsafeBytes {
        $0.baseAddress!.load(as: T.self)
    }
}

public class PlayerAbilitiesReader : MineKitPacketReader {
    public var packetID: Int = 0x32
    public var packetDirection: PacketDirection = .CLIENT
    public var connectionState: ConnectionState = .PLAY
    
    public func toPacket(fromBuffer: inout MineKitBuffer) throws -> MineKitPacket {
        var mutableBuffer = fromBuffer
        
        let flag = mutableBuffer.buffer.readInteger(endianness: .big, as: Int8.self)
        if(flag == nil) {
            throw MineKitBufferError.readError("Failed to read: flag from PlayerAbilitiesPacket!")
        }
        let speed = Float32(bitPattern: UInt32(bigEndian: fromByteArray(mutableBuffer.buffer.readBytes(length: 4)!, UInt32.self)))
        let fovModifier = Float32(bitPattern: UInt32(bigEndian: fromByteArray(mutableBuffer.buffer.readBytes(length: 4)!, UInt32.self)))
        
        fromBuffer = mutableBuffer
        return PlayerAbilitiesPacket(flag: flag!, speed: speed, fovModifier: fovModifier)
    }
}
