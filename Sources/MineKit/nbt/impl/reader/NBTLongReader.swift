public class NBTLongReader : NBTTagReader {
    public var tagId: UInt8 = 4

    public func toTag(fromBuffer: inout MineKitBuffer) throws -> NBTTag {
        return NBTLongTag(value: fromBuffer.readSignedLong())
    }
}