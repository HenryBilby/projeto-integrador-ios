//
//  FavoriteCharacterTableViewCell.swift
//  Minha_HQ_Preferida
//
//  Created by Paula Matsumoto on 13/10/21.
//

import UIKit
import Alamofire

class FavoriteCharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageFavorite : UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    public func setup(with selectedCharacter: Character){
        if let urlimage = selectedCharacter.image {
            loadImageFavoriteFromAPI(with: urlimage)
        }
        nameLabel.text = selectedCharacter.name
        descriptionLabel.text = selectedCharacter.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageFavorite.layer.cornerRadius = 20
        imageFavorite.layer.masksToBounds = true
    }
    
    private func loadImageFavoriteFromAPI(with url : String) {
        AF.request(url).responseData { response in
            if let data = response.data {
                self.imageFavorite.image = UIImage(data: data)
            }
        }
    }
}
