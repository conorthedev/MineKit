public class NBTFloatReader : NBTTagReader {
    public var tagId: UInt8 = 5

    public func toTag(fromBuffer: inout MineKitBuffer) throws -> NBTTag {
        return NBTFloatTag(value: fromBuffer.readFloat())
    }
}