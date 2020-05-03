//
//  MineKitPacket.swift
//  MineKit
//
//  Created by Conor Byrne on 03/05/2020.
//

import Foundation
import NIO

public protocol MineKitPacket {
    var packetID: UInt8 { get }
    func writeTo(buffer: inout MineKitBuffer) throws
}
