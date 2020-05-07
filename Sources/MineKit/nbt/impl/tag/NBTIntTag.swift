public class NBTIntTag : NBTTag {
    public var tagId: UInt8 = 3
    public var value: Int32

    init(value: Int32) {
        self.value = value
    }

    public func writeTo(buffer: inout MineKitBuffer) {
        buffer.writeSignedInt(value: value)
    }
}