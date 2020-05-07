public protocol NBTTagReader {
    var tagId: UInt8 { get }

    func toTag(fromBuffer: inout MineKitBuffer) throws -> NBTTag
}