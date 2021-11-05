//
//  ServiceCharacter.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import Foundation
import Alamofire

typealias ClosureDataWithMessage = ([Character]?, String)->Void

class ServiceCharacter {
    
    public func getCharacterList(completion: @escaping ClosureDataWithMessage) {
        var characterList : [Character] = []
        
        guard let url = URL(string: MarvelApiKey.urlCharacter) else {
            return completion(characterList, "Erro ao criar URL")
        }
        
        AF.request(url).responseDecodable(of: DataCharacter.self) { response in
            if let characters = response.value?.data.results {
                
                for var character in characters {
                    if !character.thumbnail.path.contains("https") {
                        character.thumbnail.path = self.changePathFromHttpToHttps(path: character.thumbnail.path)
                    }
                    
                    character.selected = false
                    character.image = "\(character.thumbnail.path).\(character.thumbnail.extension)"

                    characterList.append(character)
                }

                completion(characterList, "Sucesso ao carregar os personagens.")

            } else {
                return completion(characterList, "Erro na obtenção dos dados)")
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
