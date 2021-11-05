//
//  ComicViewModel.swift
//  Minha_HQ_Preferida
//
//  Created by Sara on 17/10/21.
//

import UIKit

protocol ComicDelegate {
    func finishLoadComics()
}

class ComicViewModel {
    
    public var delegate : ComicDelegate?
    
    var comicSelected: ComicElement?
    private var comicList: [ComicElement] = []
    private let serviceComic = ServiceComic()
    
    public func getComicList() -> [ComicElement] {
        return self.comicList
    }
    
    public func getComicListSelected() -> [ComicElement] {
        return self.comicList.filter { comicElement in
            return comicElement.selected
        }
    }
    
    public func setComicSelected( index: Int) {
        comicSelected = comicList[index]
    }
    
    public func loadComics(id: Int) {
        serviceComic.getComicList(id: id) { comicList, mensagem in
            if let list = comicList {
                DispatchQueue.main.async {
                    self.comicList = list
                    self.delegate?.finishLoadComics()
                }
            }
        }
    }
    
    public func searchComics(searchText: String) {

    }
}
