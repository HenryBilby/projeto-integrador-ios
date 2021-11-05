//
//  ServiceComic.swift
//  Minha_HQ_Preferida
//
//  Created by Sara on 17/10/21.
//

import UIKit
import Alamofire

class ServiceComic {
    
    public func getComicList(id: Int, completion: @escaping ([ComicElement]?, String)->Void) {
        
        print ("Character id na ServiceComic: \(id)")
        
        let url = "https://gateway.marvel.com/v1/public/characters/\(id)/comics?ts=1635292800&apikey=9d0e0a847010d456c3ff3466d2fc46d6&hash=af9ddc224a4c344082c1d0c90e167187"
        
        print (url)
        
        var comicList : [ComicElement] = []
        
        guard let urlFull = URL(string: url) else {
            return completion(comicList, "Erro ao criar URL")
        }

        AF.request(urlFull).responseDecodable(of: DataComic.self) { response in
            
            if let code = response.response?.statusCode, code != 200 {
                print ("Status code é: \(code)")
                return completion(comicList, "Erro na obtenção dos dados")
            }
            
            if let comics = response.value?.data.results {

                for var comic in comics {
                    if !comic.thumbnail.path.contains("https") {
                        comic.thumbnail.path = self.changePathFromHttpToHttps(path: comic.thumbnail.path)
                    }
                    
                    let comic = ComicElement(number: "#70", title: comic.title, description: comic.description, thumbnail: comic.thumbnail, selected: false, date: "07 de julho de 2021", writer: "Nick Spencer", letterer: "Federico Vicenti", editor: "Mark Bagle")
                    
                    comicList.append(comic)
                }
                completion(comicList, "Sucesso ao carregar os quadrinhos.")

            } else {
                print ("Erro na obtenção dos dados")
                return completion(comicList, "Erro na obtenção dos dados")
            }
        }.resume()
    }
    
    public func searchComicList(searchText: String,
                                completion: ([ComicElement]) -> Void) {
        
    }
    
    private func changePathFromHttpToHttps( path: String) -> String {
        if let index = path.firstIndex(of: ":") {
            return "https" + path.suffix(from: index)
        }
        return path
    }
}
