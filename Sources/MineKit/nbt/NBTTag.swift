public protocol NBTTag {
    var tagId: UInt8 { get }

    func writeTo(buffer: inout MineKitBuffer)
}