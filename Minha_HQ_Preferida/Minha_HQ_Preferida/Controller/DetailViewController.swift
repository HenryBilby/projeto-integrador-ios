//
//  DetailViewController.swift
//  Minha_HQ_Preferida
//
//  Created by Paula Matsumoto on 22/10/21.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
    @IBOutlet weak var favoriteComic: UIButton!
    @IBOutlet weak var imageViewController: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publicadoLabel: UILabel!
    @IBOutlet weak var escritorLabel: UILabel!
    @IBOutlet weak var lapisLabel: UILabel!
    @IBOutlet weak var artistaLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var voltarButton: UIButton!
    @IBOutlet weak var compartilharFavoritoButton: UIButton!
    
    var viewModel: FavoritoViewModel = .init()
    var comicElement: ComicElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carregaInformacoesComic()
        super.viewWillAppear(true)
        setButtonRadius()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        favoriteComic.isUserInteractionEnabled = true
        favoriteComic.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func adicionarButton(_ sender: Any) {
        print(imageViewController)
    }
    @IBAction func compartilharButton(_ sender: UIButton) {
        guard let nome = titleLabel.text else { return }
        guard let imagem = imageViewController.image else { return }
        let activityViewController = UIActivityViewController(activityItems: [imagem, nome], applicationActivities: nil)
                present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as? UIImageView
        favoriteComic.tintColor = .yellow
        print("A comic foi favoritada")
        print(imageViewController)
        
        let nome = titleLabel.text
        
        if let comic = comicElement {
            loadImageFromAPI(with: comic.image)
            viewModel.adicionarFavorito(nome: nome, imagem: comic.image)
        }
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
}
