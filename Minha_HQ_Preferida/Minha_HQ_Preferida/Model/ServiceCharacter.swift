//
//  ServiceCharacter.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import Foundation

class ServiceCharacter {
    
    public func getCharacterList(completion: ([CharacterElement]?, String)->Void) {
        
        let characterList : [CharacterElement]?
        
        do {
            characterList = [
                .init(id: 1, name: "Spider Woman", description: "Spider Woman helps spider man.", thumbnail: Thumbnail(caminho: "spider_woman", extensao: "jpg"), selected : false),
                .init(id: 2, name: "Spider Man", description: "Spider Man saves new york city.", thumbnail: Thumbnail(caminho: "spider_man", extensao: "jpeg"), selected : false),
                .init(id: 3, name: "Spider Man 2099", description: "Spider Man saves new york city.", thumbnail: Thumbnail(caminho: "spider_man_2099", extensao: "jpeg"), selected : false),
                .init(id: 4, name: "Iron first", description: "Iron first shows the world better.", thumbnail: Thumbnail(caminho: "iron_first", extensao: "jpeg"), selected : false),
                .init(id: 5, name: "Iron man", description: "", thumbnail: Thumbnail(caminho: "iron_man", extensao: "jpeg"), selected : false),
                .init(id: 6, name: "Iron man - Tony Stark", description: "", thumbnail: Thumbnail(caminho: "iron_man_tony_stark", extensao: "jpeg"), selected : false),
            ]
            completion(characterList, "Sucesso ao carregar os personagens.")
        } catch let error {
            print("Erro ao carregar os personagens: \(error)")
            completion(nil, "Erro ao carregar os personagens.")
        }
    }
}
