//
//  SelectCharacterViewModel.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import Foundation

class SelectCharacterViewModel {
    private var characterList : [CharacterElement] = []
    
    private let serviceCharacter = ServiceCharacter()
    
    public func loadCharacters() {
        serviceCharacter.getCharacterList { characterList, mensagem in
            print(mensagem)
            if let list = characterList {
                self.characterList = list
            }
        }
    }
    
    public func getCharactersImages() -> [String]{
        var imageList : [String] = []
        if !self.characterList.isEmpty {
            for character in self.characterList {
                let imagem = "\(character.thumbnail.caminho).\(character.thumbnail.extensao)"
                imageList.append(imagem)
            }
        }
        
        return imageList
    }
}
