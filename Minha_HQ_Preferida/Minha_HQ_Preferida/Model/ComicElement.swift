//
//  ComicElement.swift
//  Minha_HQ_Preferida
//
//  Created by Sara on 17/10/21.
//

import UIKit

class ComicElement: Codable {
    
    var number: String
    var title: String
    var description: String
    var image: String
    var selected : Bool
    var date: String
    var writer: String
    var letterer: String
    var editor: String
    
    
    init(number: String, title: String, description: String, thumbnail : Thumbnail, selected: Bool, date: String, writer: String, letterer: String, editor: String) {
        self.number = number
        self.title = title
        self.description = description
        self.image = "\(thumbnail.path).\(thumbnail.extension)"
        self.selected = selected
        self.date = date
        self.writer = writer
        self.letterer = letterer
        self.editor = editor
    }
}
