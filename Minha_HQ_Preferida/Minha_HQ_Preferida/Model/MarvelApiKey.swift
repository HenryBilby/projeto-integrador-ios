//
//  ApiKey.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import Foundation

struct MarvelApiKey {
    private static let timestamp = "1635292800"
    private static let apikey = "9d0e0a847010d456c3ff3466d2fc46d6"
    private static let hash = "af9ddc224a4c344082c1d0c90e167187"

    private static let path = "&ts=\(timestamp)&apikey=\(apikey)&hash=\(hash)"
    
    public let urlCharacter = "https://gateway.marvel.com/v1/public/characters?limit=50\(path)"
}
