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
    
    func adicionarFavorito(nome: String?, imagem: String?) -> Bool {
        guard let nome = nome,
              let imagem = imagem
        else {
            return false
        }
        
        favorito = service.adicionarFavoritoNoCoreData(nome: nome, imagem: imagem)
        delegate?.recarregaDados()
        
        return true
    }
    
    func removerFavorito(em posicao: Int) {
        favorito = service.removerFavoritoNoCoreData(favorito: favorito[posicao])
        delegate?.recarregaDados()
    }
    
    
    func quantidadeDeFavoritosNaLista() -> Int {
        return favorito.count
    }
}
