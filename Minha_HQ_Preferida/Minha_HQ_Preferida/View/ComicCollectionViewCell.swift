//
//  ComicCollectionViewCell.swift
//  Minha_HQ_Preferida
//
//  Created by Sara on 17/10/21.
//

import UIKit

import Alamofire

class ComicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleComic: UILabel!
    @IBOutlet weak var imageComic : UIImageView!
    
    public func setup(with selectedComic: ComicElement) {
        loadImageFromAPI(with: selectedComic.image)
        titleComic.text = "\(selectedComic.title) \(selectedComic.id)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageComic.layer.cornerRadius = 20
    }
    
    private func loadImageFromAPI(with url : String) {
        AF.request(url).responseData { response in
            if let data = response.data {
                self.imageComic.image = UIImage(data: data)
            }
        }
    }
    
}
