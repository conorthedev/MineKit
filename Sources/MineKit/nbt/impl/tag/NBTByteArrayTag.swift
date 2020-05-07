public class NBTByteArrayTag : NBTTag {
    public var tagId: UInt8 = 7
    public var value: [Int8]

    init(value: [Int8]) {
        self.value = value
    }

    public func writeTo(buffer: inout MineKitBuffer) {
        for i in 0..<value.count {
            buffer.writeSignedByte(value: value[i])
        }
    }
}