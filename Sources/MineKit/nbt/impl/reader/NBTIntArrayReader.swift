public class NBTIntArrayReader : NBTTagReader {
    public var tagId: UInt8 = 11

    public func toTag(fromBuffer: inout MineKitBuffer) throws -> NBTTag {
        let length = Int(fromBuffer.readSignedInt())
        var array = [Int32](repeating: 0, count: length)
        for i in 0..<length {
            array[i] = fromBuffer.readSignedInt()
        }
        return NBTIntArrayTag(value: array)
    }
}