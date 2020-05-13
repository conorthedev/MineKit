//
//  EncryptionReqResponseHandler.swift
//  MineKit
//
//  Created by Conor Byrne on 05/05/2020.
//

import Foundation
import NIO

public class EncryptionReqResponseHandler : MineKitRequestHandler {
    public var packetID: Int = 0x01
    
    public func handle(context: ChannelHandlerContext, packet: MineKitPacket) -> RequestHandlerResp {
        // This is the encryption packet ( we can assume ) so we just cast to EncryptionRequestPacket   
        let castedPacket = packet as! EncryptionRequestPacket
        
        print("\(castedPacket.publicKey)")
        
        return .success
    }
}
