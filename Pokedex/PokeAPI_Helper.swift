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
    private static let pokedexURL = "https://pokeapi.co/api/v2/pokemon"
    
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
}
