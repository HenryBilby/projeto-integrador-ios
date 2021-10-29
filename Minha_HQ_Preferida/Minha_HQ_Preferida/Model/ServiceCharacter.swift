//
//  ServiceCharacter.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import Foundation
import Alamofire

class ServiceCharacter {
    
    public func getCharacterList(completion: @escaping ([Character]?, String)->Void) {
        
        var characterList : [Character] = []
        
        guard let url = URL(string: MarvelApiKey().urlCharacter) else {
            return completion(characterList, "Erro ao criar URL")
        }
        
//        AF.request("https://httpbin.org/get").responseDecodable(of: DataCharacter.self) { response in
//            if let characters = response.value?.data.results
//            debugPrint("Response: \(response)")
//        }
        
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            if error == nil {
                guard let res = response as? HTTPURLResponse else {
                    return completion(characterList, "Erro no response")
                }
                
                if res.statusCode == 200 {
                    guard let data = data else {
                        return completion(characterList, "Erro no data")
                    }
                    
                    do {
                        let dataCharacter = try JSONDecoder().decode(DataCharacter.self, from: data)
                        
                        for var character in dataCharacter.data.results {
                            character.selected = false
                            print("Extensao: \(character.thumbnail.extension)")
                            
                            if !character.thumbnail.path.contains("https") {
                                character.thumbnail.path = self.changePathFromHttpToHttps(path: character.thumbnail.path)
                            }
                            characterList.append(character)
                            
                        }
                        completion(characterList, "Sucesso ao carregar os personagens.")
                        
                    } catch let error {
                        print("Erro ao carregar os personagens: \(error)")
                        completion(nil, "Erro ao carregar os personagens.")
                    }
                    
                } else {
                    return completion(characterList, "Erro de retorno do servidor, status code: \(res.statusCode)")
                }
            } else {
                if let error = error {
                    return completion(characterList, error.localizedDescription)
                }
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
