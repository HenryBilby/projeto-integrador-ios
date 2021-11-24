//
//  SelectCharacterViewModel.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import Foundation

protocol SelectCharacterDelegate {
    func finishLoadCharacters()
}

class SelectCharacterViewModel {
    
    public var delegate : SelectCharacterDelegate?
    
    private let serviceCharacter = CharacterService()
    private var characterList : [Character] = []
    
    public func getCharacterList() -> [Character] {
        return self.characterList
    }
    
    public func getCharacterListSelected() -> [Character] {
        return self.characterList.filter { character in
            if let selected = character.selected{
                return selected
            }
            return false
        }
    }
    
    public func setCharacterSelected( index: Int) {
        guard let selected = self.characterList[index].selected else { return }
        
        let characterListSelectedCount = getCharacterListSelected().count

        if characterListSelectedCount < 3 {
            self.characterList[index].selected = !selected
        } else if characterListSelectedCount == 3 && selected {
            self.characterList[index].selected = false
        }
    }
    
    public func loadCharacters() {
        serviceCharacter.getCharacterList { characterList, mensagem in
            if let list = characterList {
                DispatchQueue.main.async {
                    self.characterList = list
                    self.delegate?.finishLoadCharacters()
                }
            }
        }
        
    }
}
