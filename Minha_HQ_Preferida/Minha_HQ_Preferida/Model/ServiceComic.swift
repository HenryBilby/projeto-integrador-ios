//
//  ServiceComic.swift
//  Minha_HQ_Preferida
//
//  Created by Sara on 17/10/21.
//

import UIKit
import Alamofire

enum RequestAPIStatusType {
    case sucess
    case error
}

class ServiceComic {
    
    public func getComicList(id: Int, completion: @escaping ([ComicElement]?, RequestAPIStatusType)->Void) {
        var comicList : [ComicElement] = []
        
        guard let urlFull = URL(string: MarvelApiKey.getUrlComicByCharacter(characterId: id)) else {
            return completion(nil, .error)
        }

        AF.request(urlFull).responseDecodable(of: DataComic.self) { response in
            
            if let code = response.response?.statusCode, code != 200 {
                return completion(nil, .error)
            }
            
            if let comics = response.value?.data.results {

                for var comic in comics {
                    if !comic.thumbnail.path.contains("https") {
                        comic.thumbnail.path = self.changePathFromHttpToHttps(path: comic.thumbnail.path)
                    }
                    
                    let comic = ComicElement(id: comic.id, title: comic.title, description: comic.description, thumbnail: comic.thumbnail, selected: false, date: "07 de julho de 2021", writer: "Nick Spencer", letterer: "Federico Vicenti", editor: "Mark Bagle")
                    
                    comicList.append(comic)
                }
                completion(comicList, .sucess)

            } else {
                print ("Erro na obtenção dos dados")
                return completion(nil, .error)
            }
        }.resume()
    }
    
    private func changePathFromHttpToHttps( path: String) -> String {
        if let index = path.firstIndex(of: ":") {
            return "https" + path.suffix(from: index)
        }
        return path
    }
}
