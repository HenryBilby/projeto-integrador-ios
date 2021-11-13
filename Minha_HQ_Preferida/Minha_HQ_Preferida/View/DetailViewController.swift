//
//  DetailViewController.swift
//  Minha_HQ_Preferida
//
//  Created by Paula Matsumoto on 22/10/21.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
    @IBOutlet weak var favoriteComic: UIImageView!
    @IBOutlet weak var imageViewController: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publicadoLabel: UILabel!
    @IBOutlet weak var escritorLabel: UILabel!
    @IBOutlet weak var lapisLabel: UILabel!
    @IBOutlet weak var artistaLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var voltarButton: UIButton!
    
    
    var comicElement: ComicElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carregaInformacoesComic()
        super.viewWillAppear(true)
        setButtonRadius()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
           favoriteComic.isUserInteractionEnabled = true
           favoriteComic.addGestureRecognizer(tapGestureRecognizer)
        
        
//        favoriteComic.tintColor = .orange
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as? UIImageView
        favoriteComic.tintColor = .yellow
        print("A comic foi favoritada")
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func carregaInformacoesComic() {
        if let comic = comicElement {
            loadImageFromAPI(with : comic.image)
            titleLabel.text = comic.title
            publicadoLabel.text = comic.date
            escritorLabel.text = comic.writer
            lapisLabel.text = comic.letterer
            artistaLabel.text = comic.editor
            descriptionTextView.text = comic.description
            
        }
    }
    
    private func loadImageFromAPI(with url : String) {
        AF.request(url).responseData { response in
            if let data = response.data {
                self.imageViewController.image = UIImage(data: data)
            }
        }
    }
    
    private func setButtonRadius() {
        voltarButton.layer.cornerRadius = 32
    }
    
//    func setupFavoriteBtn() {
//        let tapFavoriteComic = UITapGestureRecognizer(target: self, action: #selector(favoriteComic.tappedMe))
//        favoriteComic.addGestureRecognizer(tapFavoriteComic)
//        favoriteComic.isUserInteractionEnabled = true
//    }
//
//    @objc func tappedMe()
//    {
//        print("Tapped on Image")
//    }

}
