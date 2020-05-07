import NIO

public class NBTCompoundTag : NBTTag {
    public var tagId: UInt8 = 10
    public var value: [String : NBTTag]

    init(value: [String : NBTTag]) {
        self.value = value
    }

    public func writeTo(buffer: inout MineKitBuffer) {
        for tag in value {
            buffer.buffer.writeInteger(tag.value.tagId, endianness: Endianness.big)
            
            let nameBytes = tag.key.utf8.map{UInt8($0)}
            buffer.buffer.writeInteger(UInt16(nameBytes.count), endianness: Endianness.big)
            buffer.writeBytes(bytes: nameBytes)
            
            tag.value.writeTo(buffer: &buffer)
        }
        buffer.writeByte(value: 0) // Add end tag
    }
}