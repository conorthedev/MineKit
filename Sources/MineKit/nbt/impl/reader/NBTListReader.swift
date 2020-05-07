public class NBTListReader : NBTTagReader {
    public var tagId: UInt8 = 9

    public func toTag(fromBuffer: inout MineKitBuffer) throws -> NBTTag {
        let elementTagId = fromBuffer.readByte()
        var elements = [NBTTag]()
        let count = fromBuffer.readSignedInt()
        for _ in 0..<count {
            elements.append(try NBTTags.read(tagId: elementTagId, buffer: &fromBuffer))
        }
        return NBTListTag(elementTagId: elementTagId, value: elements)
    }
}