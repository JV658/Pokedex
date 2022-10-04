//
//  Pokemon.swift
//  Pokedex
//
//  Created by Cambrian on 2022-10-04.
//

import Foundation

struct Pokemon: Codable{
    var name: String
    var sprites: [Sprite]
}

struct Sprite: Codable{
    var front_default: String
}

struct Pokedex: Codable{
    var results: [PokedexInfo]
}

struct PokedexInfo: Codable{
    var name: String
    var url: String
}
