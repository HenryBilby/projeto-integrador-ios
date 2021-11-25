//
//  File.swift
//  Minha_HQ_Preferida
//
//  Created by Paula Matsumoto on 17/11/21.
//

import Foundation
import UIKit

protocol FavoritoViewModelDelegate{
    func recarregaDados()
}
class FavoritoViewModel{
    
    var favorito: [Favorito] = []
    var delegate: FavoritoViewModelDelegate?
    
    private let service: CoreDataService = .init()
    
    func carregaDados() {
        favorito = service.pegarListaFavoritoNoCoreData()
        delegate?.recarregaDados()
    }
    
    func adicionarFavorito(nome: String?, imagem: String?) {
        favorito = service.adicionarFavoritoNoCoreData(nome: nome, imagem: imagem)
        delegate?.recarregaDados()
    }
    
    func quantidadeDeFavoritosNaLista() -> Int {
        return favorito.count
    }
}
