//
//  DeclareRecipesReader.swift
//  MineKit
//
//  Created by Conor Byrne on 05/05/2020.
//

import Foundation
import NIO

public enum MinecraftRecipeType : String {
    case shapeless = "minecraft:crafting_shapeless"
    case shaped = "minecraft:crafting_shaped"
    case smelting = "minecraft:smelting"
    case other
    
    
}

public struct MinecraftRecipe {
    public var identifier: String
    public var type: MinecraftRecipeType

    init(identifier: String, type: MinecraftRecipeType) {
        self.identifier = identifier
        self.type = type
    }
}

public class DeclareRecipesReader : MineKitPacketReader {
    public var packetID: Int = 0x5B
    public var packetDirection: PacketDirection = .CLIENT
    public var connectionState: ConnectionState = .PLAY
    
    public func toPacket(fromBuffer: inout MineKitBuffer) throws -> MineKitPacket {
        var mutableBuffer = fromBuffer
        let numRecipies = try mutableBuffer.readVarInt()
        
        var recipeList = [MinecraftRecipe]()
        
        var type: String
        var recipeID: String
        var width: Int
        var height: Int
        var group: String
        var count: Int
        var isPresent: Bool
        var itemID: Int
        var itemCount: UInt8
        
        for _ in 0..<numRecipies {
            type = try mutableBuffer.readString()
            recipeID = try mutableBuffer.readString()
            
            if(type.starts(with: "minecraft:crafting_special_")) {
                recipeList.append(MinecraftRecipe(identifier: recipeID, type: MinecraftRecipeType.init(rawValue: type) ?? .other))
                break
            }

            if(type == "minecraft:crafting_shaped") {
                width = try mutableBuffer.readVarInt()
                height = try mutableBuffer.readVarInt()
                group = try mutableBuffer.readString()
                
                count = try mutableBuffer.readVarInt()
                isPresent = mutableBuffer.readByte() != 0
                if(isPresent) {
                    itemID = try mutableBuffer.readVarInt()
                    itemCount = mutableBuffer.readByte()
                }
            }
            
            recipeList.append(MinecraftRecipe(identifier: recipeID, type: MinecraftRecipeType.init(rawValue: type) ?? .other))
        }
        
        fromBuffer = mutableBuffer
        return DeclareRecipesPacket(numRecipies: recipeList.count, recipeArray: recipeList)
    }
}
