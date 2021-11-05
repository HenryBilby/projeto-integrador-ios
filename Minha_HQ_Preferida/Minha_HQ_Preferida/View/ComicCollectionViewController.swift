//
//  ComicCollectionViewController.swift
//  Minha_HQ_Preferida
//
//  Created by Sara on 17/10/21.
//

import UIKit

class ComicCollectionViewController : UIViewController {
    
    public var character: Character?
    
    @IBOutlet private weak var searchComic: UISearchBar!
    @IBOutlet private weak var comicCollectionView: UICollectionView!
    
    private let selectComicViewModel = ComicViewModel()
    var selectedComic: ComicElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setDataSources()
        loadComics()
        setCollectionView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DetailViewController {
            controller.comicElement = sender as? ComicElement
        }
    }
    
    private func setDelegates() {
        comicCollectionView.delegate = self
        searchComic.delegate = self
        selectComicViewModel.delegate = self
    }
    
    private func setDataSources() {
        comicCollectionView.dataSource = self
    }
    
    private func setCollectionView() {
        comicCollectionView.dataSource = self
        comicCollectionView.layer.cornerRadius = 32
        searchComic.layer.cornerRadius = 32
    }
    
    private func loadComics() {
        if let id = character?.id {
            selectComicViewModel.loadComics(id: id)
        }
    }
}

extension ComicCollectionViewController : ComicDelegate {
    func finishLoadComics() {
        comicCollectionView.reloadData()
    }
}

extension ComicCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: selectComicViewModel.getComicList()[indexPath.row])
    }
}

extension ComicCollectionViewController: UICollectionViewDataSource {
    
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
