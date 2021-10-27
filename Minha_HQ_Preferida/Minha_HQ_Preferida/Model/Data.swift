//
//  Character.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 27/10/21.
//

import Foundation

struct Data : Codable {
    var data : Characters
}

struct Characters : Codable {
    var results : [Character]
}

struct Character : Codable {
    let id : Int
    let name: String
    let description: String
    let thumbnail : Thumbnail1
}

struct Thumbnail1 : Codable {
    let path : String
}
