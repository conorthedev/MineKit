public class NBTLongArrayReader : NBTTagReader {
    public var tagId: UInt8 = 12

    public func toTag(fromBuffer: inout MineKitBuffer) throws -> NBTTag {
        let length = Int(fromBuffer.readSignedInt())
        var array = [Int64](repeating: 0, count: length)
        for i in 0..<length {
            array[i] = fromBuffer.readSignedLong()
        }
        return NBTLongArrayTag(value: array)
    }
}