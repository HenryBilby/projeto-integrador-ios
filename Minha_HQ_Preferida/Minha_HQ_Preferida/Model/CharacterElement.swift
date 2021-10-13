//
//  Character.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import Foundation

class CharacterElement {
    let id : Int
    let name: String
    let description: String
    let image : String
    var selected : Bool
    
    init(id : Int, name: String, description: String, thumbnail : Thumbnail, selected : Bool) {
        self.id = id
        self.name = name
        self.description = description
        self.image = "\(thumbnail.caminho).\(thumbnail.extensao)"
        self.selected = selected
    }
}
