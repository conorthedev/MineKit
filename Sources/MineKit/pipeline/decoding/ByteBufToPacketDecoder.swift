//
//  ByteBufToPacketDecoder.swift
//  MineKit
//
//  Created by Conor Byrne on 03/05/2020.
//

import Foundation
import NIO

public enum MineKitPacketError : Error {
    case cannotParse(String)
    case parsingFailed(String)
}

final class ByteBufToPacketDecoder : ByteToMessageDecoder {
    typealias InboundOut = MineKitPacket
    var packetDecoderMap = [
        0x00: DisconnectLoginReader(),
        0x01: EncryptionRequestReader(),
        0x02: LoginSuccessReader(),
        0x03: SetCompressionReader(),
        0x04: LoginPluginReqReader(),
        0x19: PluginMessageReader(),
        0x26: JoinGameReader(),
        0x32: PlayerAbilitiesReader(),
        0x34: PlayerInfoReader(),
        0x40: HeldItemChangeReader(),
        0x0E: ServerDifficultyReader(),
        0x5B: DeclareRecipesReader()
    ] as [Int : MineKitPacketReader]

    func decode(context: ChannelHandlerContext, buffer: inout ByteBuffer) throws -> DecodingState {
        if(buffer.readableBytes == 0) {
            return .needMoreData
        }

        // Cast our buffer to MineKitBuffer and get the length (which is a VarInt like wtf minecraft use normal shit)
        var minekitBuf = MineKitBuffer(withByteBuffer: buffer)
        var numRead = 0
        var packetLength = 0
        var read: Int = 0
        repeat {
            if(minekitBuf.buffer.readableBytes == 0) {
                return .needMoreData
            }
            
            read = Int(minekitBuf.readByte())
            let value = read & 0b01111111
            packetLength = packetLength | (value << (7 * numRead))
            numRead += 1
            if(numRead > 5) {
                throw MineKitBufferError.readError("VarInt too large!")
            }
        } while((read & 0b10000000) != 0)
        
        if(minekitBuf.buffer.readableBytes < packetLength) {
            return .needMoreData
        }
                
        // Slice the buffer from the byte after the varint to the packet length
        let slicedBuffer = minekitBuf.buffer.getSlice(at: minekitBuf.buffer.readerIndex, length: packetLength)!
        var minekitSlicedBuf = MineKitBuffer(withByteBuffer: slicedBuffer)
        let packetID = try minekitSlicedBuf.readVarInt()
            
        MineKit.shared.logger.info("Parsing packet \(packetID) or 0x\(String(format:"%02X", packetID)) of length \(packetLength)")
        
        if(packetDecoderMap.contains(where: { (arg0) -> Bool in
            let (key, _) = arg0
            if(key == packetID) {
                return true
            } else {
                return false
            }
        })) {
            let reader = packetDecoderMap[packetID]!
            let packet = try reader.toPacket(fromBuffer: &minekitSlicedBuf)
            
            buffer = minekitSlicedBuf.buffer

            if (buffer.readableBytes > 0) {
                throw MineKitPacketError.parsingFailed("Packet \(packetID) wasn't fully read (\(buffer.readableBytes) bytes left)")
            }

            context.fireChannelRead(NIOAny(packet))
            
            return .needMoreData
        } else {
            throw MineKitPacketError.cannotParse("Unable to parse packet: \(packetID)")
        }
    }
}
