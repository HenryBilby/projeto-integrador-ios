//
//  Character.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 27/10/21.
//

import Foundation

struct DataCharacter : Codable {
    let data : Characters
}

struct Characters : Codable {
    let results : [Character]
}

struct Character : Codable {
    let id : Int
    let name: String
    let description: String
    var thumbnail : Thumbnail
    var selected : Bool?
    var image : String?
}

struct Thumbnail : Codable {
    var path : String
    let `extension`: String
}
