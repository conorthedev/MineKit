public class NBTByteReader : NBTTagReader {
    public var tagId: UInt8 = 1

    public func toTag(fromBuffer: inout MineKitBuffer) throws -> NBTTag {
        return NBTByteTag(value: fromBuffer.readSignedByte())
    }
}