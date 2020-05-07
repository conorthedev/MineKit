import NIO

public class NBTListTag : NBTTag {
    public var tagId: UInt8 = 9
    public var elementTagId: UInt8
    public var value: [NBTTag]

    init(elementTagId: UInt8, value: [NBTTag]) {
        self.elementTagId = elementTagId
        self.value = value
    }

    public func writeTo(buffer: inout MineKitBuffer) {
        buffer.buffer.writeInteger(elementTagId, endianness: Endianness.big)
        buffer.writeSignedInt(value: Int32(value.count))
        for tag in value {
            tag.writeTo(buffer: &buffer)
        }
    }
}