//
//  DeclareRecipesPacket.swift
//  MineKit
//
//  Created by Conor Byrne on 05/05/2020.
//

import Foundation
import NIO

public class DeclareRecipesPacket : MineKitPacket {
    public var packetID: UInt8 = 0x5B
    public var numberOfRecipies: Int
    public var recipeArray = [MinecraftRecipe]()
    
    public func writeTo(buffer: inout MineKitBuffer) throws {
        throw MineKitBufferError.writeError("Unable to write DeclareRecipesPacket to buffer: Not implemented")
    }
    
    init(numRecipies: Int, recipeArray: [MinecraftRecipe]) {
        self.numberOfRecipies = numRecipies
        self.recipeArray = recipeArray
    }
}
