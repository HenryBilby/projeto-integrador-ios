//
//  FavoriteCharacterTableViewCell.swift
//  Minha_HQ_Preferida
//
//  Created by Paula Matsumoto on 13/10/21.
//

import UIKit

class FavoriteCharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageFavorite : UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descricptionLabel: UILabel!
    
    var selectedCharacters: CharacterElement?
    
    
    public func setup(with selectedCharacters: CharacterElement){
        imageFavorite.image = UIImage(named: selectedCharacters.image)
        nameLabel.text = selectedCharacters.name
        descricptionLabel.text = selectedCharacters.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageFavorite.layer.cornerRadius = 20
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
