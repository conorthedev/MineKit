public class NBTFloatTag : NBTTag {
    public var tagId: UInt8 = 5
    public var value: Float32

    init(value: Float32) {
        self.value = value
    }

    public func writeTo(buffer: inout MineKitBuffer) {
        buffer.writeFloat(value: value)
    }
}