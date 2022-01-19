//
//  Minha_HQ_PreferidaTests.swift
//  Minha_HQ_PreferidaTests
//
//  Created by Henry Bilby on 07/10/21.
//

import XCTest
@testable import Minha_HQ_Preferida

class Minha_HQ_PreferidaTests: XCTestCase {
    
    func testFavoritoViewModel_dadoQueFuncaoAdicionarFavoritoEhChamada_quandoReceberNomeEImagemComoNil_entaoDeverRetornarFalso() {
        
        let viewModel = FavoritoViewModel()
        let favoritado = viewModel.adicionarFavorito(nome: nil, imagem: nil)
        
        XCTAssertFalse(favoritado)
    }

}
