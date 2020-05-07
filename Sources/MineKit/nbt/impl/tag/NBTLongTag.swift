public class NBTLongTag : NBTTag {
    public var tagId: UInt8 = 4
    public var value: Int64

    init(value: Int64) {
        self.value = value
    }

    public func writeTo(buffer: inout MineKitBuffer) {
        buffer.writeSignedLong(value: value)
    }
}