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
                .init(number: "#70", title: "O Espetacular Homem Aranha (2018)", description: "PRELÚDIO DE GUERRA SINISTRO! A Guerra Sinistra vira a vida de Spidey de cabeça para baixo, mas o fato de que KING'S RANSOM e CHAMELEON CONSPIRACY já fizeram isso, pode lhe dar uma ideia de como isso vai ser difícil para Peter Parker.", thumbnail: Thumbnail(path: "setenta", extension: "jpg"), selected: false, date: "07 de julho de 2021", writer: "Nick Spencer", letterer: "Federico Vicenti", editor: "Mark Bagle"),
                .init(number: "#36", title: "O Espetacular Homem-Aranha (2020)", description: "", thumbnail: Thumbnail(path: "trintaeseis", extension: "jpg"), selected: false, date: "07 de julho de 2021", writer: "Nick Spencer", letterer: "Federico Vicenti", editor: "Mark Bagle"),
                .init(number: "#1", title: "O Espetacular Homem-Aranha (2019)", description: "", thumbnail: Thumbnail(path: "um", extension: "jpg"), selected: false, date: "07 de julho de 2021", writer: "Nick Spencer", letterer: "Federico Vicenti", editor: "Mark Bagle"),
                .init(number: "#301", title: "O Espetacular Homem-Aranha (2017)", description: "", thumbnail: Thumbnail(path: "trezentoseum", extension: "jpg"), selected: false, date: "07 de julho de 2021", writer: "Nick Spencer", letterer: "Federico Vicenti", editor: "Mark Bagle"),
                .init(number: "#60", title: "O Incrível Homem-Aranha (2018)", description: "", thumbnail: Thumbnail(path: "sessenta", extension: "jpg"), selected: false, date: "07 de julho de 2021", writer: "Nick Spencer", letterer: "Federico Vicenti", editor: "Mark Bagle"),
                .init(number: "#4", title: "O Espetacular Homem-Aranha  (2017)", description: "", thumbnail: Thumbnail(path: "quatro", extension: "jpg"), selected: false, date: "07 de julho de 2021", writer: "Nick Spencer", letterer: "Federico Vicenti", editor: "Mark Bagle"),
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
