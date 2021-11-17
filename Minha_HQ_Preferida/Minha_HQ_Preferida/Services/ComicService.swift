//
//  ServiceComic.swift
//  Minha_HQ_Preferida
//
//  Created by Sara on 17/10/21.
//

import Alamofire
import UIKit

enum RequestAPIStatusType {
    case sucess
    case error
}

class ComicService {
    
    public func getComicList(id: Int, completion: @escaping ([ComicElement]?, RequestAPIStatusType) -> Void) {
        var comicList : [ComicElement] = []
        
        guard let fullURL = URL(string: MarvelApiKey.getURLComicByCharacter(characterId: id)) else {
            return completion(nil, .error)
        }
        
        AF.request(fullURL).responseDecodable(of: DataComic.self) { response in
            
            if let code = response.response?.statusCode, code != 200 {
                return completion(nil, .error)
            }
            
            if let comics = response.value?.data.results {
                
                for var comic in comics {
                    if !comic.thumbnail.path.contains("https") {
                        comic.thumbnail.path = self.changePathFromHttpToHttps(path: comic.thumbnail.path)
                    }
                    
                    var data = ""
                    for date in comic.dates {
                        if date.type == "onsaleDate" {
                            data = date.date
                            break
                        }
                    }
                    
                    var writer = ""
                    var letterer = ""
                    var editor = ""
                    
                    for item in comic.creators.items {
                        
                        if item.role.lowercased() == "writer" {
                            writer.append("\(item.name), ")
                            
                        } else if item.role.lowercased() == "letterer" {
                            letterer.append("\(item.name), ")
                            
                        } else if item.role.lowercased() == "editor" {
                            editor.append("\(item.name), ")
                        }
                    }
                    
                    let comic = ComicElement(id: comic.id,
                                             title: comic.title,
                                             description: comic.description,
                                             thumbnail: comic.thumbnail,
                                             selected: false,
                                             date: data,
                                             writer: writer,
                                             letterer: letterer,
                                             editor: editor)
                    
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
