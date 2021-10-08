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
                .init(id: 7, name: "Hulk", description: "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.", thumbnail: Thumbnail(caminho: "hulk", extensao: "jpg"), selected : false),
                .init(id: 8, name: "Hulk-Has", description: "The Hulk is the biggest, strongest, smashing-est hero in the Marvel Universe - the green glue that holds his crazy family-like team together. Hulk loves saving the world by smashing every alien, sea creature, and planet (literally) that tries to destroy it. He is the star of his best bud A-Bomb's web series, and just wants to show people his good intentions!", thumbnail: Thumbnail(caminho: "hulk_has", extensao: "jpeg"), selected : false),
                .init(id: 9, name: "Hulk-Lego", description: "", thumbnail: Thumbnail(caminho: "hulk_lego", extensao: "jpeg"), selected : false),
                .init(id: 10, name: "Captain America", description: "Vowing to serve his country any way he could, young Steve Rogers took the super soldier serum to become America's one-man army. Fighting for the red, white and blue for over 60 years, Captain America is the living, breathing symbol of freedom and liberty.", thumbnail: Thumbnail(caminho: "capitao_america", extensao: "jpeg"), selected : false),
                .init(id: 11, name: "Wolverine", description: "Born with super-human senses and the power to heal from almost any wound, Wolverine was captured by a secret Canadian organization and given an unbreakable skeleton and claws. Treated like an animal, it took years for him to control himself. Now, he's a premiere member of both the X-Men and the Avengers.", thumbnail: Thumbnail(caminho: "wolverine", extensao: "jpeg"), selected : false),
                .init(id: 12, name: "Black Bolt", description: "", thumbnail: Thumbnail(caminho: "black_bolt", extensao: "jpeg"), selected : false),
            ]
            completion(characterList, "Sucesso ao carregar os personagens.")
        } catch let error {
            print("Erro ao carregar os personagens: \(error)")
            completion(nil, "Erro ao carregar os personagens.")
        }
    }
}
