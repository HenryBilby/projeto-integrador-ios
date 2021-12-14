//
//  CoreDataService.swift
//  Minha_HQ_Preferida
//
//  Created by Paula Matsumoto on 19/11/21.
//

import Foundation
import UIKit

class CoreDataService {

     private var favorito: [Favorito] = []
     private let context = ((UIApplication.shared.delegate)
                   as! AppDelegate)
        .persistentContainer
        .viewContext


     func pegarListaFavoritoNoCoreData() -> [Favorito] {
        do {
            favorito = try context.fetch(Favorito.fetchRequest())
            return favorito
        } catch {
            print(error.localizedDescription)
            return []
        }
     
    }

     func adicionarFavoritoNoCoreData(nome: String?, imagem: String?) -> [Favorito] {
        let favorito: Favorito = .init(context: context)
        favorito.nome = nome
        favorito.imagem = imagem

        saveContext()

        return pegarListaFavoritoNoCoreData()
    }
    
    

     func removerFavoritoNoCoreData(favorito: Favorito) -> [Favorito] {
        context.delete(favorito)
        saveContext()

        return pegarListaFavoritoNoCoreData()
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {

        }
    }
}
