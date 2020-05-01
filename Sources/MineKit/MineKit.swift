import NIO

struct MineKit {
    func sendPacket(packet: Packet, withContext: ChannelHandlerContext) {
        var buffer = withContext.channel.allocator.buffer(capacity: packet.actualLength)
        var compiledPacket = [packet.contentLength, packet.packetID]
        
        compiledPacket += packet.data
        buffer.writeBytes(compiledPacket)
        withContext.writeAndFlush(NIOAny(buffer), promise: nil)
    }
}

protocol Packet {
    var packetID: UInt8 { get }
    var data: [UInt8] { get }
    var contentLength: UInt8 { get }
    var actualLength: Int { get }
}

// last: next state (1 status, 2 login)
class HandshakePacket : Packet {
    var packetID: UInt8 = 0x00
    var contentLength: UInt8 = 0x10
    var data: [UInt8] = [0xC2, 0x04, 0x09, 0x6C, 0x6F, 0x63, 0x61, 0x6C, 0x68, 0x6F, 0x73, 0x74, 0x63, 0xDD, 0x02]
    var actualLength: Int = 17
}
