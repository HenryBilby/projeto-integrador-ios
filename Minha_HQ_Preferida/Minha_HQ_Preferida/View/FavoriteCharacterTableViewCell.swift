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
    @IBOutlet weak var descriptionLabel: UILabel!
    
    public func setup(with selectedCharacter: Character){
        imageFavorite.image = UIImage(named: selectedCharacter.thumbnail.path+selectedCharacter.thumbnail.extension)
        nameLabel.text = selectedCharacter.name
        descriptionLabel.text = selectedCharacter.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageFavorite.layer.cornerRadius = 20
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
