public class NBTShortTag : NBTTag {
    public var tagId: UInt8 = 2
    public var value: Int16

    init(value: Int16) {
        self.value = value
    }

    public func writeTo(buffer: inout MineKitBuffer) {
        buffer.writeSignedShort(value: value)
    }
}