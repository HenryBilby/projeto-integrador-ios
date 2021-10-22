//
//  ComicCollectionViewController.swift
//  Minha_HQ_Preferida
//
//  Created by Sara on 17/10/21.
//

import UIKit

class ComicCollectionViewController : UIViewController {
    
    public var character: CharacterElement?
    
    @IBOutlet private weak var searchComic: UISearchBar!
    @IBOutlet private weak var selectComic: UICollectionView!
    
    private let selectComicViewModel = ComicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectComicViewModel.loadComics()
        setCollectionView()
        print(character?.name)
    }
    
    private func setCollectionView() {
        selectComic.dataSource = self
        selectComic.delegate = self
        selectComic.layer.cornerRadius = 32
        
        searchComic.delegate = self
    }
}

extension ComicCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectComicViewModel.setComicSelected(index: indexPath.row)
        // lembra de add o identificador no segue
        performSegue(withIdentifier: "detailView", sender: selectComicViewModel.comicSelected)
    }
}

extension ComicCollectionViewController:
    UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectComicViewModel.getComicList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comicCell", for: indexPath) as? ComicCollectionViewCell {
            cell.setup(with: selectComicViewModel.getComicList()[indexPath.row])
            return cell
            
        }
        
        return UICollectionViewCell()
    }
}

extension ComicCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//                ComicViewModel.searchComics = searchText
    }
}
