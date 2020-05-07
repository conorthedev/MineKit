public class NBTLongArrayTag : NBTTag {
    public var tagId: UInt8 = 12
    public var value: [Int64]

    init(value: [Int64]) {
        self.value = value
    }

    public func writeTo(buffer: inout MineKitBuffer) {
        for i in 0..<value.count {
            buffer.writeSignedLong(value: value[i])
        }
    }
}