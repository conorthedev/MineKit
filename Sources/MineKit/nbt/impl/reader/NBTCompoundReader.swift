public class NBTCompoundReader : NBTTagReader {
    public var tagId: UInt8 = 10

    public func toTag(fromBuffer: inout MineKitBuffer) throws -> NBTTag {
        // fromBuffer.buffer.readString(length: Int(fromBuffer.readShort()))!
        var map = [:] as [String : NBTTag]
        while (true) {
            let tagId = fromBuffer.readByte()
            if (tagId == 0) {
                break
            }
            let tagName = fromBuffer.buffer.readString(length: Int(fromBuffer.readShort()))!
            let tag = try NBTTags.read(tagId: tagId, buffer: &fromBuffer)
            map[tagName] = tag
        }
        return NBTCompoundTag(value: map)
    }
}