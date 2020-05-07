public class NBTIntReader : NBTTagReader {
    public var tagId: UInt8 = 3

    public func toTag(fromBuffer: inout MineKitBuffer) throws -> NBTTag {
        return NBTIntTag(value: fromBuffer.readSignedInt())
    }
}