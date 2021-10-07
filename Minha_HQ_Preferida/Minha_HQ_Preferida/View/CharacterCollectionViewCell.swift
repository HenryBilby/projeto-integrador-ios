//
//  CharacterCollectionViewCell.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCharacter : UIImageView!
    
    public func setup(with imagePath: String) {
        imageCharacter.image = UIImage(named: imagePath)
    }
}
