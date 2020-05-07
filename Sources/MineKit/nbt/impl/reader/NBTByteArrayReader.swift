public class NBTByteArrayReader : NBTTagReader {
    public var tagId: UInt8 = 7

    public func toTag(fromBuffer: inout MineKitBuffer) throws -> NBTTag {
        let length = Int(fromBuffer.readSignedInt())
        var bytes = [Int8](repeating: 0, count: length)
        for i in 0..<length {
            bytes[i] = fromBuffer.readSignedByte()
        }
        return NBTByteArrayTag(value: bytes)
    }
}