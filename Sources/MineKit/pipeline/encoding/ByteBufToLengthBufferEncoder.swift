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
        MineKitCoderUtils.writeVarInt(withValue: data.readableBytes, toBuffer: &out)
        var varData = data
        out.writeBuffer(&varData)
    }
}
