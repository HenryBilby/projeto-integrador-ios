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
//    var publicado: String
    
    init(number: String, title: String, description: String, thumbnail : Thumbnail, selected: Bool) {
        self.number = number
        self.title = title
        self.description = description
        self.image = "\(thumbnail.caminho).\(thumbnail.extensao)"
        self.selected = selected
    }
}
