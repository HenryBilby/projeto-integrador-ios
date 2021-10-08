//
//  CharacterCollectionViewCell.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCharacter : UIImageView!
    
    public func setup(with character : CharacterElement) {
        imageCharacter.image = UIImage(named: character.image)
        
        if (character.selected) {
            imageCharacter.layer.borderColor = UIColor.red.cgColor
            imageCharacter.layer.borderWidth = 5
        } else {
            imageCharacter.layer.borderColor = UIColor.clear.cgColor
            imageCharacter.layer.borderWidth = 0
        }

    }
}
