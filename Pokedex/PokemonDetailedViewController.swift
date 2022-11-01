//
//  PokemonDetailedViewController.swift
//  Pokedex
//
//  Created by Cambrian on 2022-10-11.
//

import UIKit

class PokemonDetailedViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var pokeUIImage: UIImageView!
    
    var pokemon: Pokemon!
    var pokemonURL: String?
//    var pokeImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let pokemon = pokemon{
            pokeUIImage.image = UIImage(data: pokemon.imageData!)
            nameLabel.text = pokemon.name
            idLabel.text = String(pokemon.id)
            heightLabel.text = String(pokemon.height)
            weightLabel.text = String(pokemon.weight)
        } else {
            //fetch pokeinfo and store in Pokemon
            Task{
                do{
                    pokemon = try await PokeAPI_Helper.fetchPokemon(pokemonURL: pokemonURL!)
                    nameLabel.text = pokemon.name
                    idLabel.text = String(pokemon.id)
                    heightLabel.text = String(pokemon.height)
                    weightLabel.text = String(pokemon.weight)
                    pokemon.imageData = try await PokeAPI_Helper.fetchImage(imageURL: pokemon.sprites.front_default)
                    pokeUIImage.image = UIImage(data: pokemon.imageData!)
                } catch let err{
                    print(err)
                }
            }
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let dst = segue.destination as! SpriteCollectionViewController
        dst.sprite = pokemon.sprites
    }

}
