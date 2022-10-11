//
//  TableViewCell.swift
//  Pokedex
//
//  Created by Cambrian on 2022-10-11.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var defaultSprite: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
