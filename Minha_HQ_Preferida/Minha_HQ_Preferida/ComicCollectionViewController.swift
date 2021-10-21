//
//  ComicCollectionViewController.swift
//  Minha_HQ_Preferida
//
//  Created by Sara on 17/10/21.
//

import UIKit

class ComicCollectionViewController : UIViewController {
    
    @IBOutlet weak var searchComic: UISearchBar!
    @IBOutlet weak var selectComic: UICollectionView!
    
    let selectComicViewModel = ComicViewModel()
    
    var selectedComicViewModel: [ComicElement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectComicViewModel.loadComics()
        setCollectionView()
    
    }
    
    private func setCollectionView() {
        selectComic.dataSource = self
        selectComic.delegate = self
        selectComic.layer.cornerRadius = 32
        
        searchComic.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let comicCollection = segue.destination as? ComicCollectionViewController, segue.identifier == "comicCollectionSegue" {
//            comicCollection.selectedComicViewModel = sender as? [ComicElement]
        }
    }
}

extension ComicCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectComicViewModel.setComicSelected(index: indexPath.row)
        self.selectComic.reloadData()
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
