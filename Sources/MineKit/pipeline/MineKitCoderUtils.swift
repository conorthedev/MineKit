//
//  MineKitCoderUtils.swift
//  MineKit
//
//  Created by Conor Byrne on 03/05/2020.
//

import Foundation
import NIO

final class MineKitCoderUtils {
    public static func writeByte(withValue: Int, toBuffer: inout ByteBuffer) {
        toBuffer.writeBytes([UInt8(withValue)])
    }

    public static func writeVarInt(withValue: Int, toBuffer: inout ByteBuffer) {
        var toWrite = withValue
        repeat {
            var temp = (toWrite & 0b01111111)
            toWrite = toWrite >> 7
            if(toWrite != 0) {
                temp = (Int(temp) | 0b10000000)
            }
            writeByte(withValue: temp, toBuffer: &toBuffer)
        } while (toWrite != 0)
    }
}
