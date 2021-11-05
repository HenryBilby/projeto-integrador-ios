//
//  DataComic.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 05/11/21.
//

import Foundation

struct DataComic : Codable {
    let data : Comics
}

struct Comics : Codable {
    let results : [Comic]
}

struct Comic : Codable {
    let id : Int
    let title: String
    let description: String
    let dates : [Date]
    var thumbnail : Thumbnail
    let creators : Creators
}

struct Date : Codable {
    let type : String
    let date : String
}

struct Creators : Codable {
    let items : [Item]
}

struct Item : Codable {
    let name : String
    let role : String
}
