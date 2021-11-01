//
//  CharacterCollectionViewCell.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import UIKit
import Alamofire

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCharacter : UIImageView!
    
    public func setup(with character : Character) {
        if let urlImage = character.image {
            loadImageFromAPI(with: urlImage)
        }

        imageCharacter.layer.cornerRadius = 20
        
        if let selected = character.selected {
            if (selected) {
                imageCharacter.layer.borderColor = UIColor.red.cgColor
                imageCharacter.layer.borderWidth = 5
            } else {
                imageCharacter.layer.borderColor = UIColor.clear.cgColor
                imageCharacter.layer.borderWidth = 0
            }
            
        }

    }
    
    private func loadImageFromAPI(with url : String) {
        AF.request(url).responseData { response in
            if let data = response.data {
                self.imageCharacter.image = UIImage(data: data)
            }
        }
    }
}
