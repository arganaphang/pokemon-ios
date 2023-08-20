//
//  Pokemon.swift
//  pokemon
//
//  Created by Argana Phangquestian on 20/08/23.
//

import Foundation
import SwiftUI


struct Stat: Codable, Hashable {
    let key: String
    let value: Int
    var color: Color {
        get {
            Color(key)
        }
    }
}

struct Pokemon: Codable, Identifiable {
    let id: Int
    let name: String
    var height: Int
    let weight: Int
    let stats: [Stat]
    let types: [String]
    
    var color: Color {
        get {
            return types.isEmpty ? Color(.white) : Color(types.first!)
        }
    }
    
    var imageUrl: URL {
        get {
            URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")!
        }
    }
}
