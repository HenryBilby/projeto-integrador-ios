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
        if let comic = comicElement {
            imageViewController.image = UIImage(named: comic.image)
            titleLabel.text = comic.title
            publicadoLabel.text = comic.date
            escritorLabel.text = comic.writer
            lapisLabel.text = comic.letterer
            artistaLabel.text = comic.editor
            descriptionTextView.text = comic.description
            
        }
    }
    private func setButtonRadius() {
        voltarButton.layer.cornerRadius = 32
    }
}
