import XCTest
import NIO

@testable import MineKit

final class MineKitTests: XCTestCase {
    func testExample() {
        print(MineKitBuffer().compilePacket(packet: HandshakePacket()))
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
