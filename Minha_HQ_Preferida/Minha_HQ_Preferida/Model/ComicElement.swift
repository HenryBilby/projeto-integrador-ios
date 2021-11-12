//
//  ComicElement.swift
//  Minha_HQ_Preferida
//
//  Created by Sara on 17/10/21.
//

import UIKit

class ComicElement: Codable {
    let id: Int
    let title: String
    let description: String
    let image: String
    let selected : Bool
    let date: String
    let writer: String
    let letterer: String
    let editor: String
    
    
    init(id: Int, title: String, description: String, thumbnail : Thumbnail, selected: Bool, date: String, writer: String, letterer: String, editor: String) {
        self.id = id
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
