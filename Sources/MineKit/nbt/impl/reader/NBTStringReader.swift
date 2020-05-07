public class NBTStringReader : NBTTagReader {
    public var tagId: UInt8 = 8

    public func toTag(fromBuffer: inout MineKitBuffer) throws -> NBTTag {
        return NBTStringTag(value: fromBuffer.buffer.readString(length: Int(fromBuffer.readShort()))!)
    }
}