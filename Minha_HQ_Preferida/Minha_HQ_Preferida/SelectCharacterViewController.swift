//
//  SelectCharacterViewController.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import UIKit

class SelectCharacterViewController: UIViewController {

    @IBOutlet weak var selectCharacterLabel: UILabel!
    @IBOutlet weak var selectCharacterCollectioView: UICollectionView!
    
    let selectCharacterViewModel = SelectCharacterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCharacterViewModel.loadCharacters()
        setLabelRadius()
        selectCharacterCollectioView.delegate = self
        selectCharacterCollectioView.dataSource = self
    }
    
    private func setLabelRadius() {
        selectCharacterLabel.layer.cornerRadius = 32
        selectCharacterLabel.layer.masksToBounds = true
    }

}

extension SelectCharacterViewController: UICollectionViewDelegate {
    
}

extension SelectCharacterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectCharacterViewModel.getCharactersImages().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as? CharacterCollectionViewCell {
            cell.setup(with: selectCharacterViewModel.getCharactersImages()[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}
