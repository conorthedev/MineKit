//
//  MineKitPacket.swift
//  MineKit
//
//  Created by Conor Byrne on 03/05/2020.
//

import Foundation
import NIO

protocol Packet {
    func getBuffer(withBuffer: ByteBuffer) -> ByteBuffer
}
