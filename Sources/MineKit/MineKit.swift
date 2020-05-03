import NIO

public struct MineKit {
    private let hostname: String
    private let port: Int
    private let username: String
    private let context: ChannelHandlerContext
    
    init(hostname: String, port: Int, context: ChannelHandlerContext, username: String) {
        self.hostname = hostname
        self.port = port
        self.context = context
        self.username = username
    }
    
    public func connectToServer() {
        sendPacket(packet: HandshakePacket(withHostname: hostname, andPort: port))
        sendPacket(packet: LoginStartPacket(withUsername: username))
    }
    
    func sendPacket(packet: Packet) {
        let buffer = context.channel.allocator.buffer(capacity: 11)
        context.writeAndFlush(NIOAny(packet.getBuffer(withBuffer: buffer)), promise: nil)
    }
}
