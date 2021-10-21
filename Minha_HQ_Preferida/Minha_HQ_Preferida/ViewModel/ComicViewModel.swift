//
//  ComicViewModel.swift
//  Minha_HQ_Preferida
//
//  Created by Sara on 17/10/21.
//

import UIKit

class ComicViewModel {
    
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
        let comicListSelectedCount = getComicListSelected().count
    }
    
    public func loadComics() {
        serviceComic.getComicList { comicList, mensagem in
            print(mensagem)
            if let list = comicList {
                self.comicList = list
            }
        }
    }
    
    public func searchComics(searchText: String) {
        // jogar no service só o filter (linha 35)
        comicList = getComicList().filter({ (comic) -> Bool in
            return comic.title.lowercased().contains(searchText.lowercased())
        })
    }
}
