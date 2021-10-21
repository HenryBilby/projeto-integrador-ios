//
//  ServiceComic.swift
//  Minha_HQ_Preferida
//
//  Created by Sara on 17/10/21.
//

import UIKit

class ServiceComic {
    
    public func getComicList(completion: ([ComicElement]?, String)->Void) {
        
        let comicList : [ComicElement]?
        
        do {
            comicList = [
                .init(number: "#70", title: "O Espetacular Homem Aranha (2018)", description: "", thumbnail: Thumbnail(caminho: "setenta", extensao: "jpg"), selected: false),
                .init(number: "#36", title: "O Espetacular Homem-Aranha (2020)", description: "", thumbnail: Thumbnail(caminho: "trintaeseis", extensao: "jpg"), selected: false),
                .init(number: "#1", title: "O Espetacular Homem-Aranha (2019)", description: "", thumbnail: Thumbnail(caminho: "um", extensao: "jpg"), selected: false),
                .init(number: "#301", title: "O Espetacular Homem-Aranha (2017)", description: "", thumbnail: Thumbnail(caminho: "trezentoseum", extensao: "jpg"), selected: false),
                .init(number: "#60", title: "O Incrível Homem-Aranha (2018)", description: "", thumbnail: Thumbnail(caminho: "sessenta", extensao: "jpg"), selected: false),
                .init(number: "#4", title: "O Espetacular Homem-Aranha  (2017)", description: "", thumbnail: Thumbnail(caminho: "quatro", extensao: "jpg"), selected: false),
            ]
            
            completion(comicList, "Sucesso ao carregar os personagens.")
        } catch let error {
            print("Erro ao carregar os personagens: \(error)")
            completion(nil, "Erro ao carregar os personagens.")
        }
    }
    
    public func searchComicList(searchText: String,
                                completion: ([ComicElement]) -> Void) {
        
    }
}
