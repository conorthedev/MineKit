import XCTest
import NIO

@testable import MineKit

final class MineKitTests: XCTestCase, ChannelInboundHandler {
    let defaultHost = "systemless.me"
    let defaultPort: Int = 25565

    public typealias InboundIn = ByteBuffer
    public typealias OutboundIn = ByteBuffer
    public typealias OutboundOut = MineKitPacket
           
    public func channelActive(context: ChannelHandlerContext) {
        print("🌐 Client connected to \(context.remoteAddress!)")
        let minekit = MineKit(hostname: defaultHost, port: defaultPort, context: context, username: "ConorDoesMC")
        minekit.connectToServer()
    }

    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let byteBuffer = self.unwrapInboundIn(data)
    }

    public func errorCaught(context: ChannelHandlerContext, error: Error) {
        print("🚫 Error: ", error)
        context.close(promise: nil)
        XCTFail("Error occured: \(error)")
    }

    func testLogin() {
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let bootstrap = ClientBootstrap(group: group)
            .channelInitializer { channel in
                channel.pipeline.addHandler(ByteToMessageHandler(ByteBufToPacketDecoder()))
                channel.pipeline.addHandler(MessageToByteHandler(ByteBufToLengthBufferEncoder()), name: "1", position: ChannelPipeline.Position.first)
                channel.pipeline.addHandler(self, name: "3", position: ChannelPipeline.Position.last)
                return channel.pipeline.addHandler(MessageToByteHandler(PacketToByteBufEncoder()), name: "2", position: ChannelPipeline.Position.before(self))
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
            print("🚫 Error: \(error)")
            XCTFail("Error occured: \(error)")
        }

        print("🚪 Client closed!")
        XCTAssertTrue(true)
    }

    static var allTests = [
        ("testLogin", testLogin),
    ]
}
