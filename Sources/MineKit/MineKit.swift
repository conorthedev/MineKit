import NIO

public class MineKitBuffer {
    private var buffer: ByteBuffer
    init(withByteBuffer: ByteBuffer) {
        buffer = withByteBuffer
    }
    
    func writeBytes(bytes: [UInt8]) {
        print("Writing: \(bytes)")
        buffer.writeBytes(bytes)
    }
    
    func writeByte(value: Int) {
        print("Writing: \(value)")
        buffer.writeBytes([UInt8(value)])
    }
    
    func writeVarInt(value: Int) {
        var toWrite = value
        repeat {
            var temp = (toWrite & 0b01111111)
            toWrite = toWrite << 7
            if(toWrite != 0) {
                temp = (Int(temp) | 0b10000000)
            }
            self.writeByte(value: temp)
        } while (toWrite != 0)
    }
    
    func writeString(value: String, max: Int) -> ByteBuffer {
        if(value.count > max) {
            print("String length higher than expected! | Got \(value.count), expected \(max)")
        }
        let bytes = value.utf8.map{UInt8($0)}
        writeVarInt(value: bytes.count)
        writeBytes(bytes: bytes)
        
        return buffer
    }
}

struct MineKit {
    func sendPacket(packet: Packet, withContext: ChannelHandlerContext) {
        if(packet is HandshakePacket) {
            var buffer = withContext.channel.allocator.buffer(capacity: packet.actualLength)
            var compiledPacket = [0x10, packet.packetID]

            compiledPacket += packet.data

            print("sending: \(compiledPacket)")
            buffer.writeBytes(compiledPacket)
            withContext.writeAndFlush(NIOAny(buffer), promise: nil)
        } else {
            var buffer = withContext.channel.allocator.buffer(capacity: packet.actualLength)
            var compiledPacket = [packet.packetID]

            compiledPacket += packet.data

            print("sending: \(compiledPacket)")
            buffer.writeBytes(compiledPacket)
            withContext.writeAndFlush(NIOAny(buffer), promise: nil)
        }
       
    }
    
    func sendLoginStartPacket(withContext: ChannelHandlerContext) {
        var buffer = withContext.channel.allocator.buffer(capacity:23)
        var compiledPacket = [0x0D, 0x00, 0x0B] as [UInt8]
        compiledPacket += "ConorDoesMC".utf8.map{UInt8($0)}
                
        print("sending: \(compiledPacket)")
        buffer.writeBytes(compiledPacket)
        withContext.writeAndFlush(NIOAny(buffer), promise: nil)
    
    }
}

protocol Packet {
    var packetID: UInt8 { get }
    var data: [UInt8] { get }
    var actualLength: Int { get }
}

// last: next state (1 status, 2 login)
class HandshakePacket : Packet {
    var packetID: UInt8 = 0x00
    var data: [UInt8] = [0xC2, 0x04]
    var actualLength: Int = 17
    
    init(ip: String) {
        let iputf = ip.utf8.map{UInt8($0)}
        data += [UInt8(iputf.count)]
        data += iputf
        data += [0x63, 0xDE, 2]
    }
}

/*class LoginPacket : Packet {
    var packetID: UInt8 = 0x00
    var data: [UInt8]
    var actualLength: Int
    
    init(name: String) {
    }
}*/
