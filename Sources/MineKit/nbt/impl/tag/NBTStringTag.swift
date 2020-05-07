import NIO

public class NBTStringTag : NBTTag {
    public var tagId: UInt8 = 8
    public var value: String

    init(value: String) {
        self.value = value
    }

    public func writeTo(buffer: inout MineKitBuffer) {
        let bytes = value.utf8.map{UInt8($0)}
        buffer.buffer.writeInteger(UInt16(bytes.count), endianness: Endianness.big)
        buffer.writeBytes(bytes: bytes)
    }
}