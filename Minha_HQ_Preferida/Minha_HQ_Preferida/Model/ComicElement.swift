//
//  ComicElement.swift
//  Minha_HQ_Preferida
//
//  Created by Sara on 17/10/21.
//

import UIKit

class ComicElement {
    
    var number: String
    var title: String
    var description: String
    var image: String
    var selected : Bool
    var publicado: String
    var escritor: String
    var lapis: String
    var artistaCapa: String
    
    
    init(number: String, title: String, description: String, thumbnail : Thumbnail, selected: Bool, publicado: String, escritor: String, lapis: String, artistaCapa: String) {
        self.number = number
        self.title = title
        self.description = description
        self.image = "\(thumbnail.path).\(thumbnail.extension)"
        self.selected = selected
        self.publicado = publicado
        self.escritor = escritor
        self.lapis = lapis
        self.artistaCapa = artistaCapa
    }
}
