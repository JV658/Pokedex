//
//  PokeAPI_Helper.swift
//  Pokedex
//
//  Created by Cambrian on 2022-10-04.
//

import Foundation

enum PokeAPI_Errors: Error{
    case stringToURLError
}

class PokeAPI_Helper{
    private static let pokedexURL = "https://pokeapi.co/api/v2/pokemon?limit=500"
    
    public static func fetchPokedex() async throws -> Pokedex{
        guard
            let url = URL(string: pokedexURL)
        else {
            throw PokeAPI_Errors.stringToURLError
        }
        
        let request = URLRequest(url: url)

        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        
        let pokedex = try decoder.decode(Pokedex.self, from: data)
        
        return pokedex
    }
    
    public static func fetchPokemon(pokemonURL: String) async throws -> Pokemon{
        guard
            let url = URL(string: pokemonURL)
        else { throw PokeAPI_Errors.stringToURLError}
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        
        let pokemon = try decoder.decode(Pokemon.self, from: data)
        
        return pokemon
    }
    
    public static func fetchImage(imageURL: String) async throws -> Data{
        for _ in 0...1000000{
            continue
        }
        
        print("image was fetched for: \(imageURL)")
        guard
            let url = URL(string: imageURL)
        else { throw PokeAPI_Errors.stringToURLError}
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return data
    }
}
