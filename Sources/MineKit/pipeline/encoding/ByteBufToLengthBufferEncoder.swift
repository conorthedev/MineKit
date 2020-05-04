//
//  ByteBufToLengthBufferEncoder.swift
//  MineKit
//
//  Created by Conor Byrne on 03/05/2020.
//

import Foundation
import NIO

final class ByteBufToLengthBufferEncoder : MessageToByteEncoder {
    typealias OutboundIn = ByteBuffer
    
    func encode(data: ByteBuffer, out: inout ByteBuffer) throws {
        var dataCpy = ByteBuffer(ByteBufferView.init(data))
        
        MineKitCoderUtils.writeVarInt(withValue: dataCpy.readableBytes, toBuffer: &out)
        out.writeBuffer(&dataCpy)
    }
}
