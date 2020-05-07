public class NBTDoubleTag : NBTTag {
    public var tagId: UInt8 = 6
    public var value: Float64

    init(value: Float64) {
        self.value = value
    }

    public func writeTo(buffer: inout MineKitBuffer) {
        buffer.writeDouble(value: value)
    }
}