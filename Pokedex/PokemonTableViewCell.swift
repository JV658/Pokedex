//
//  TableViewCell.swift
//  Pokedex
//
//  Created by Cambrian on 2022-10-11.
//

import UIKit
import CoreData

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var isFav: UIButton!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var defaultSprite: UIImageView!
    var fav = false
    var persistentContainer: NSPersistentContainer!
    var managedObject: Favorites!
    
    @IBAction func toggleFav(_ sender: UIButton) {
        let moc = persistentContainer.viewContext
        if fav {
            sender.imageView!.image = UIImage(systemName: "star")
            sender.tintColor = .black
            fav = false
            moc.delete(managedObject)
            persistentContainer.saveContext()
        } else {
            sender.imageView!.image = UIImage(systemName: "star.fill")
            sender.tintColor = .yellow
            fav = true
            let favorite = Favorites(context: moc)
            favorite.name = pokeNameLabel.text
            persistentContainer.saveContext()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
