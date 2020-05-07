public class NBTDoubleReader : NBTTagReader {
    public var tagId: UInt8 = 6

    public func toTag(fromBuffer: inout MineKitBuffer) throws -> NBTTag {
        return NBTDoubleTag(value: fromBuffer.readDouble())
    }
}