//
//  PlayerAbilitiesPacket.swift
//  MineKit
//
//  Created by Conor Byrne on 05/05/2020.
//

import Foundation
import NIO

public class PlayerAbilitiesPacket : MineKitPacket {
    public var packetID: UInt8 = 0x32
    public var flag: Int8
    public var speed: Float32
    public var fovModifier: Float32
    
    public func writeTo(buffer: inout MineKitBuffer) throws {
        throw MineKitBufferError.writeError("Unable to write PlayerAbilitiesPacket to buffer: Not implemented")
    }
    
    init(flag: Int8, speed: Float32, fovModifier: Float32) {
        self.flag = flag
        self.speed = speed
        self.fovModifier = fovModifier
    }
}
