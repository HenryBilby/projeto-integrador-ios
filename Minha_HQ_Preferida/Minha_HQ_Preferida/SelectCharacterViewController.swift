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
        setCollectionView()
    }
    
    private func setLabelRadius() {
        selectCharacterLabel.layer.cornerRadius = 32
        selectCharacterLabel.layer.masksToBounds = true
    }
    
    private func setCollectionView() {
        selectCharacterCollectioView.delegate = self
        selectCharacterCollectioView.dataSource = self
        selectCharacterCollectioView.layer.cornerRadius = 32
    }

}

extension SelectCharacterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectCharacterViewModel.setCharacterSelected(index: indexPath.row)
        self.selectCharacterCollectioView.reloadData()
        
        print("\n")
        for character in selectCharacterViewModel.getCharacterListSelected() {
            print("\(character.name) está selecionado")
        }
    }
    
}

extension SelectCharacterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectCharacterViewModel.getCharacterList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as? CharacterCollectionViewCell {
            cell.setup(with: selectCharacterViewModel.getCharacterList()[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}
