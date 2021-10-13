//
//  SelectCharacterViewController.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import UIKit

class SelectCharacterViewController: UIViewController {

    @IBOutlet weak var selectCharacterLabel: UILabel!
    @IBOutlet weak var avancarButton: UIButton!
    @IBOutlet weak var selectCharacterCollectioView: UICollectionView!
    
    
    let selectCharacterViewModel = SelectCharacterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCharacterViewModel.loadCharacters()
        setLabelRadius()
        setButtonRadius()
        setCollectionView()
    }
    
    @IBAction func actionAvancarButton(_ sender: Any) {
        if selectCharacterViewModel.getCharacterListSelected().count == 3 {
            performSegue(withIdentifier: "showCharactersSegue", sender: avancarButton)
        } else {
            showDialog(message: "Favor selecionar 3 personagens", title: "Atenção")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let showSelectedCharacters = segue.destination as? ShowSelectedCharactersViewController ,segue.identifier == "showCharactersSegue" {
            showSelectedCharacters.selectedCharacters = selectCharacterViewModel.getCharacterListSelected()
        }
    }
    
    private func showDialog(message :String, title: String) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
          })
         
        dialogMessage.addAction(ok)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    private func setButtonRadius() {
        avancarButton.layer.cornerRadius = 32
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
