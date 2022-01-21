//
//  Minha_HQ_PreferidaTests.swift
//  Minha_HQ_PreferidaTests
//
//  Created by Henry Bilby on 07/10/21.
//

import XCTest
@testable import Minha_HQ_Preferida

class Minha_HQ_PreferidaTests: XCTestCase {
    
    private var sutFavorito : FavoritoViewModel!
    private var sutLogin : LoginViewModel!
    private var sutSelectCharacter : SelectCharacterViewModel!
    
    override func setUp() {
        super.setUp()
        sutFavorito = FavoritoViewModel()
        sutLogin = LoginViewModel()
        sutSelectCharacter = SelectCharacterViewModel()
    }
    
    override func tearDown() {
        sutFavorito = nil
        sutLogin = nil
        sutSelectCharacter = nil
        super.tearDown()
    }
    
    func testFavoritoViewModel_dadoQueFuncaoAdicionarFavoritoEhChamada_quandoReceberNomeEImagemComoNil_entaoDeverRetornarFalso() {
        let favoritado = sutFavorito.adicionarFavorito(nome: nil, imagem: nil)
        
        XCTAssertFalse(favoritado)
    }
    
    func testLoginViewModel_dadoQueFuncaoIsValidTextFieldEhChamada_quandoReceberTextFieldComoNil_entaoDeveRetornarFalso() {
        let textField = UITextField()
        let isValidTextField = sutLogin.isValid(textField: textField)
        
        XCTAssertFalse(isValidTextField)
    }
    
    func testSelectCharacterViewModel_dadoQueFuncaoGetCharacterListSelectedEhChamada_entaoDeveRetornarUmaListaDeCharactersComSelectedVerdadeiro () {
        let listCharacters : [Character] = [
            .init(id: 1, name: "SpiderMan", description: "SpiderMan saves New York city", thumbnail: Thumbnail(path: "spider", extension:  "jpg"), selected: true, image: nil),
            .init(id: 2, name: "SpiderWoman", description: "SpiderWoman saves New York city", thumbnail: Thumbnail(path: "spiderWoman", extension:  "jpg"), selected: true, image: nil),
            .init(id: 3, name: "Hulk", description: "Eu estou sempre com raiva", thumbnail: Thumbnail(path: "hulk", extension:  "jpg"), selected: false, image: nil)
            ]
        
        sutSelectCharacter.setCharacterList(list: listCharacters)
        
        let listCharactersSelectedTrue = sutSelectCharacter.getCharacterListSelected()
        
        for character in listCharactersSelectedTrue {
            XCTAssertTrue(character.selected!)
        }
    }

}
