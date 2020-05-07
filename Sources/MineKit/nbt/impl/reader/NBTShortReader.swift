public class NBTShortReader : NBTTagReader {
    public var tagId: UInt8 = 2

    public func toTag(fromBuffer: inout MineKitBuffer) throws -> NBTTag {
        return NBTShortTag(value: fromBuffer.readSignedShort())
    }
}