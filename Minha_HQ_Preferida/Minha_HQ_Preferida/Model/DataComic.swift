//
//  DataComic.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 05/11/21.
//

import Foundation

struct DataComic : Decodable {
    let data : Comics
}

struct Comics : Decodable {
    let results : [Comic]
}

struct Comic : Decodable {
    let id : Int
    let title: String
    let description: String
    let dates : [Date]
    var thumbnail : Thumbnail
    let creators : Creators
}

struct Date : Decodable {
    let type : String
    let date : String
}

struct Creators : Decodable {
    let items : [Item]
}

struct Item : Decodable {
    let name : String
    let role : String
}
