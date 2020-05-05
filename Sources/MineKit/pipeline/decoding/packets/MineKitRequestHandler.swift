//
//  RequestHandler.swift
//  MineKit
//
//  Created by Conor Byrne on 05/05/2020.
//

import Foundation
import NIO

public enum RequestHandlerResp {
    case success, failed
}

public protocol MineKitRequestHandler {
    var packetID: Int { get }
    func handle(context: ChannelHandlerContext, packet: MineKitPacket) -> RequestHandlerResp
}

public class MineKitRequestManager {
    public static var packetHandlerMap = [
        0x01: EncryptionReqResponseHandler()
    ] as [UInt8 : MineKitRequestHandler]
}
