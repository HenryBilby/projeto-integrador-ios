//
//  FavoritoTableViewCell.swift
//  Minha_HQ_Preferida
//
//  Created by Paula Matsumoto on 19/11/21.
//

import UIKit
import Alamofire

class FavoritoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var imagemFavorito: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imagemFavorito.layer.cornerRadius = 16
        imagemFavorito.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // comunicacao com a detail para fazer
    }
    
    func setup(nome: String, imagem: String) {
        nomeLabel.text = "\(nome)"
        loadImageFromAPI(with: imagem)

    }
    
    
    
    private func loadImageFromAPI(with url : String) {
        AF.request(url).responseData { response in
            if let data = response.data {
                self.imagemFavorito.image = UIImage(data: data)
            }
        }
    }
}
