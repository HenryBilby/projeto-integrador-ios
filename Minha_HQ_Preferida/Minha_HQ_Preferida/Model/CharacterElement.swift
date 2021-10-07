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
    let thumbnail : Thumbnail
    
    init(id : Int, name: String, description: String, thumbnail : Thumbnail) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
    }
}
