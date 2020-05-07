public final class NBTTags {
    private static let readerMap = [
        0x01 : NBTByteReader(),
        0x02 : NBTShortReader(),
        0x03 : NBTIntReader(),
        0x04 : NBTLongReader(),
        0x05 : NBTFloatReader(),
        0x06 : NBTDoubleReader(),
        0x07 : NBTByteArrayReader(),
        0x08 : NBTStringReader(),
        0x09 : NBTListReader(),
        0x0a : NBTCompoundReader(),
        0x0b : NBTIntArrayReader(),
        0x0c : NBTLongArrayReader()
    ] as [UInt8 : NBTTagReader]

    public static func read(tagId: UInt8, buffer: inout MineKitBuffer) throws -> NBTTag {
        print("bruh \(tagId) \(readerMap) \(readerMap[tagId])")
        return try readerMap[tagId]!.toTag(fromBuffer: &buffer)
    }
}