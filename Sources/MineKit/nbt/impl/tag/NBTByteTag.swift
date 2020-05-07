public class NBTByteTag : NBTTag {
    public var tagId: UInt8 = 1
    public var value: Int8

    init(value: Int8) {
        self.value = value
    }

    public func writeTo(buffer: inout MineKitBuffer) {
        buffer.writeSignedByte(value: value)
    }
}