//
//  SelectCharacterViewModel.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import Foundation

class SelectCharacterViewModel {
    private let serviceCharacter = ServiceCharacter()
    private var characterList : [CharacterElement] = []
    
    public func getCharacterList() -> [CharacterElement] {
        return self.characterList
    }
    
    public func getCharacterListSelected() -> [CharacterElement] {
        return self.characterList.filter { characterElement in
            return characterElement.selected
        }
    }
    
    public func setCharacterSelected( index: Int) {
        let characterListSelectedCount = getCharacterListSelected().count
        
        if characterListSelectedCount < 3 {
            self.characterList[index].selected = !self.characterList[index].selected
        } else if characterListSelectedCount == 3 && self.characterList[index].selected {
            self.characterList[index].selected = false
        }
    }
    
    public func loadCharacters() {
        serviceCharacter.getCharacterList { characterList, mensagem in
            print(mensagem)
            if let list = characterList {
                self.characterList = list
            }
        }
        
    }
}
