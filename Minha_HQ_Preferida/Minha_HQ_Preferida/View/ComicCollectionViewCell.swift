//
//  ComicCollectionViewCell.swift
//  Minha_HQ_Preferida
//
//  Created by Sara on 17/10/21.
//

import UIKit

class ComicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleComic: UILabel!
    @IBOutlet weak var imageComic : UIImageView!
    
    public func setup(with selectedComic: ComicElement) {
        imageComic.image = UIImage(named: selectedComic.image)
        titleComic.text = "\(selectedComic.title) \(selectedComic.number)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageComic.layer.cornerRadius = 20
    }
    
}
