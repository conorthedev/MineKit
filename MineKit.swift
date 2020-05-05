import NIO

public enum MineKitError : Error {
    case notSetup(String)
}

public struct MineKit {
    static var shared = MineKit()

    var hostname: String = "not setup"
    var port: Int = 0
    var username: String = "not setup"
    var context: ChannelHandlerContext? = nil
    var isReady: Bool = false
        
    public mutating func setup(hostname: String, port: Int, context: ChannelHandlerContext, username: String) {
        self.hostname = hostname
        self.port = port
        self.context = context
        self.username = username
        self.isReady = true
    }
    
    public func connectToServer() throws {
        if(!isReady) {
            throw MineKitError.notSetup("MineKit was not setup! Setup with MineKit.shared.setup(...)")
        }
        try sendPacket(packet: HandshakePacket(withHostname: hostname, andPort: port))
        try sendPacket(packet: LoginStartPacket(withUsername: "ConorDoesMC"))
    }
    
    public func sendMessage() throws {
        if(!isReady) {
            throw MineKitError.notSetup("MineKit was not setup! Setup with MineKit.shared.setup(...)")
        }
        try sendPacket(packet: ChatMessagePacket(withMessage: "hi"))
    }
    
    func sendPacket(packet: MineKitPacket) throws {
        if(!isReady) {
            throw MineKitError.notSetup("MineKit was not setup! Setup with MineKit.shared.setup(...)")
        }
        print("📨 Sending packet: \(String(describing: packet))")
        context!.writeAndFlush(NIOAny(packet), promise: nil)
        print("📩 Sent packet: \(String(describing: packet))")
    }
}
