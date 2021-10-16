//
//  ShowSelectedCharactersViewController.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 08/10/21.
//

import UIKit

class ShowSelectedCharactersViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteTableView: UITableView!
    
    public var selectedCharacters : [CharacterElement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        setTableView()
    }
    
    private func setLabel() {
        titleLabel.layer.cornerRadius = 32
        titleLabel.layer.masksToBounds = true
    }
    
    private func setTableView(){
        favoriteTableView.layer.cornerRadius = 32
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
    }
}

extension ShowSelectedCharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(selectedCharacters[indexPath.row].name)
    }
}

extension ShowSelectedCharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell  = tableView.dequeueReusableCell(withIdentifier: "favoriteTableViewCell", for: indexPath) as? FavoriteCharacterTableViewCell {
            cell.setup(with: selectedCharacters[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
