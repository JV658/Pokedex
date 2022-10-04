//
//  PokeAPI_Helper.swift
//  Pokedex
//
//  Created by Cambrian on 2022-10-04.
//

import Foundation

enum PokedexResponse{
    case success([PokedexInfo])
    case failure(Error)
}

enum PokedexError: Error{
    case urlConversionError
    case unknownError
}

class PokeAPI_Helper{
    private static let pokedexURL = "https://pokeapi.co/api/v2/pokemon"
    
    public static func fetchPokedex(callback: @escaping (PokedexResponse)->Void){
        guard
            let url = URL(string: pokedexURL)
        else {
            callback(.failure(PokedexError.urlConversionError))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if let data = data {
                do{
                    let decoder = JSONDecoder()
                    let pokedexData = try decoder.decode(Pokedex.self, from: data)
                    callback(.success(pokedexData.results))
                } catch let err {
                    print("there was an erro: \(err)")
                    callback(.failure(err))
                }
            } else if let error = error {
                callback(.failure(error))
            } else {
                print("some random error occured")
                callback(.failure(PokedexError.unknownError))
            }
        }
        task.resume()
    }
}
