import XCTest
import NIO

@testable import MineKit

final class MineKitTests: XCTestCase, ChannelInboundHandler {
    let defaultHost = "localhost"
    let defaultPort: Int = 25565
    
    public typealias InboundIn = ByteBuffer
    public typealias OutboundOut = ByteBuffer
           
    public func channelActive(context: ChannelHandlerContext) {
        print("Client connected to \(context.remoteAddress!)")
        print("sending handshake")
        MineKit().sendPacket(packet: HandshakePacket(ip: defaultHost), withContext: context)
        print("Sent handshake")
        print("sending login")
        MineKit().sendLoginStartPacket(withContext: context)
        print("sent login")
    }

    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let byteBuffer = self.unwrapInboundIn(data)
        print("recieved: \(String(buffer: byteBuffer))")
        
        //MineKit().sendPacket(packet: LoginPacket(name: "ConorDoesMC"), withContext: context)
    }

    public func errorCaught(context: ChannelHandlerContext, error: Error) {
       print("error: ", error)
       context.close(promise: nil)
    }

    func testExample() {
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let bootstrap = ClientBootstrap(group: group)
            // Enable SO_REUSEADDR.
            .channelInitializer { channel in
                channel.pipeline.addHandler(self)
            }
        defer {
            try! group.syncShutdownGracefully()
        }

        enum ConnectTo {
            case ip(host: String, port: Int)
            case unixDomainSocket(path: String)
        }

        let connectTarget: ConnectTo = .ip(host: defaultHost, port: defaultPort)

        do {
            let channel = try { () -> Channel in
                switch connectTarget {
                case .ip(let host, let port):
                    return try bootstrap.connect(host: host, port: port).wait()
                case .unixDomainSocket(let path):
                    return try bootstrap.connect(unixDomainSocketPath: path).wait()
                }
            }()

            // Will be closed after we echo-ed back to the server.
            try channel.closeFuture.wait()
        } catch let error {
            print(error)
        }

        print("Client closed")

    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
