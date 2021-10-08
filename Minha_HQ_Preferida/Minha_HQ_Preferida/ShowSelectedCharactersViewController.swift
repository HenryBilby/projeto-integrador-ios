//
//  ShowSelectedCharactersViewController.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 08/10/21.
//

import UIKit

class ShowSelectedCharactersViewController: UIViewController {
    
    public var selectedCharacters : [CharacterElement] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        testandoSelectedCharacters()
    }
    
    //TODO: Eliminar este método depois que começar a implementação desta view
    private func testandoSelectedCharacters() {
        for character in selectedCharacters {
            print("\(character.name) chegou selecionado em ShowSelectedCharactersViewController")
        }
    }
}
