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
    @IBOutlet weak var descricaoText: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carregaInformacoesComic(with selectedComic: ComicElement)
        super.viewWillAppear(true)
        // Do any additional setup after loading the view.
    }
    
    func carregaInformacoesComic(with selectedComic: ComicElement) {
        imageViewController.image = UIImage(named: selectedComic.image )
                                            
    }
}
