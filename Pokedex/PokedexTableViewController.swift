//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Cambrian on 2022-10-04.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    var pokedex = [PokedexInfo]()
    var pokemonDetails = [String: Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        Task{
            do{
                let results = try await PokeAPI_Helper.fetchPokedex()
                pokedex = results.results
                tableView.reloadData()
            } catch PokeAPI_Errors.stringToURLError {
                print("there was an error converting the string to a url")
            } catch let err {
                print(err)
            }

        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("pokedex count: \(pokedex.count)")
        return pokedex.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemon", for: indexPath) as! PokemonTableViewCell
        
        let pokename = pokedex[indexPath.row].name
        
        // MARK: TODO - refine this code to store the image data in the internal memory
        if let pokemon = pokemonDetails[pokename]{
            cell.defaultSprite.image = UIImage(data: pokemon.imageData!)
        } else {
            Task{
                let pokemonURL = pokedex[indexPath.row].url
                do{
                    
                    // fetch pokemon data
                    var pokemon = try await PokeAPI_Helper.fetchPokemon(pokemonURL: pokemonURL)
                    // fetch front_dfault image data
                    let defaultSprite = try await PokeAPI_Helper.fetchImage(imageURL: pokemon.sprites.front_default)
                    // set cell image to uiimage of defaultSprite data (front_default)
                    cell.defaultSprite.image = UIImage(data: defaultSprite)
                    // storing the image data in pokemon instance
                    pokemon.imageData = defaultSprite
                    // storing the pokemon instance in the pokedetails dictionary
                    pokemonDetails[pokename] = pokemon
                    
                } catch let err {
                    print(err)
                }
            }
        }
        
        // Configure the cell...
        cell.pokeNameLabel.text = pokename

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let dst = segue.destination as! PokemonDetailedViewController
        let index = tableView.indexPathForSelectedRow!.row
        let pokename = pokedex[index].name
        dst.pokemon = pokemonDetails[pokename]
    }

}
