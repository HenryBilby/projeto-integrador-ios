//
//  DetailViewController.swift
//  Minha_HQ_Preferida
//
//  Created by Paula Matsumoto on 22/10/21.
//

import UIKit

class DetailViewController: UIViewController {
    
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
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func carregaInformacoesComic() {
        if let image = comicElement?.image {
            imageViewController.image = UIImage(named: image)
        }
        titleLabel.text = comicElement?.title
        publicadoLabel.text = comicElement?.publicado
        escritorLabel.text = comicElement?.escritor
        lapisLabel.text = comicElement?.lapis
        artistaLabel.text = comicElement?.artistaCapa
        descriptionTextView.text = comicElement?.description
    }
    private func setButtonRadius() {
        voltarButton.layer.cornerRadius = 32
    }
}
