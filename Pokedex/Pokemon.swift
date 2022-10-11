//
//  Pokemon.swift
//  Pokedex
//
//  Created by Cambrian on 2022-10-04.
//

import Foundation

struct Pokemon: Codable{
    var name: String
    var sprites: Sprite
    var forms: [Forms]
    var height: Int
    var weight: Int
    var id: Int
    var imageData: Data?
}

struct Sprite: Codable{
    var front_default: String
}

struct Forms: Codable{
    var name: String
}

struct Pokedex: Codable{
    var results: [PokedexInfo]
}

struct PokedexInfo: Codable{
    var name: String
    var url: String
}
