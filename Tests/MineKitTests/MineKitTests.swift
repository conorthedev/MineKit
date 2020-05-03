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
        MineKit(hostname: defaultHost, port: defaultPort, context: context, username: "ConorDoesMC").connectToServer()
    }

    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let byteBuffer = self.unwrapInboundIn(data)
        print("recieved: \(String(buffer: byteBuffer))")
    }

    public func errorCaught(context: ChannelHandlerContext, error: Error) {
        print("error: ", error)
        context.close(promise: nil)
        XCTFail("Error occured: \(error)")
    }

    func testLogin() {
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let bootstrap = ClientBootstrap(group: group)
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
            XCTFail("Error occured: \(error)")
        }

        print("Client closed")
        XCTAssertTrue(true)
    }

    static var allTests = [
        ("testLogin", testLogin),
    ]
}
