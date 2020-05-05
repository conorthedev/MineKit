//
//  PacketReader.swift
//  MineKit
//
//  Created by Conor Byrne on 04/05/2020.
//

import Foundation
import NIO

public enum PacketDirection {
    case CLIENT, SERVER
}

public enum ConnectionState {
    case HANDSHAKE, LOGIN, PLAY
}

public protocol MineKitPacketReader {
    var packetID: Int { get }
    var packetDirection: PacketDirection { get }
    var connectionState: ConnectionState { get }
    
    func toPacket(fromBuffer: inout MineKitBuffer) throws -> MineKitPacket
}
