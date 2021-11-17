//
//  ComicViewModel.swift
//  Minha_HQ_Preferida
//
//  Created by Sara on 17/10/21.
//

import UIKit

protocol ComicDelegate {
    func sucessLoadComics(type: RequestAPIStatusType)
    func errorLoadComics(type: RequestAPIStatusType)
}

class ComicViewModel {
    
    public var delegate : ComicDelegate?
    
    private var comicList: [ComicElement] = []
    private let serviceComic = ComicService()
    
    public func getComicList() -> [ComicElement] {
        return self.comicList
    }
    
    public func loadComics(id: Int) {
        serviceComic.getComicList(id: id) { comicList, status in
            DispatchQueue.main.async {
                switch status {
                case .sucess:
                    if let list = comicList, !list.isEmpty {
                            self.comicList = list
                            self.delegate?.sucessLoadComics(type: status)
                    } else {
                        self.delegate?.errorLoadComics(type: .error)
                    }
                case .error:
                    self.delegate?.errorLoadComics(type: status)
                }
            }
            
            
        }
    }
    
    public func searchComics(searchText: String) {
        let list = self.comicList.filter({ comic in
            return comic.description.contains(searchText) || comic.title.contains(searchText)
        })
        
        if !list.isEmpty {
            self.comicList = list
        }
    }
}
