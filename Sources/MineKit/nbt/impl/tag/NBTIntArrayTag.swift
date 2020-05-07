public class NBTIntArrayTag : NBTTag {
    public var tagId: UInt8 = 11
    public var value: [Int32]

    init(value: [Int32]) {
        self.value = value
    }

    public func writeTo(buffer: inout MineKitBuffer) {
        for i in 0..<value.count {
            buffer.writeSignedInt(value: value[i])
        }
    }
}