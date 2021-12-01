//
//  ComicCollectionViewController.swift
//  Minha_HQ_Preferida
//
//  Created by Sara on 17/10/21.
//

import UIKit

class ComicCollectionViewController : UIViewController {
    
    public var character: Character?
    
    @IBOutlet private weak var comicSearch: UISearchBar!
    @IBOutlet private weak var comicCollectionView: UICollectionView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var listaPersonagemFavoritoButton: UIButton!
//        didSet {
//            listaPersonagemFavoritoButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
//        }
//    }
    
    private let comicViewModel = ComicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setDataSources()
        loadComics()
        setCollectionView()
        setButtonRadius()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DetailViewController {
            controller.comicElement = sender as? ComicElement
        }
    }
    
    private func setDelegates() {
        comicCollectionView.delegate = self
        comicSearch.delegate = self
        comicViewModel.delegate = self
    }
    
    private func setDataSources() {
        comicCollectionView.dataSource = self
    }
    
    private func setCollectionView() {
        comicCollectionView.dataSource = self
        comicCollectionView.layer.cornerRadius = 32
        comicCollectionView.layer.masksToBounds = true
        
        comicSearch.layer.cornerRadius = 28
        comicSearch.layer.masksToBounds = true
    }
    
    private func setButtonRadius() {
        listaPersonagemFavoritoButton.layer.cornerRadius = 32
        listaPersonagemFavoritoButton.layer.masksToBounds = true
//        listaPersonagemFavoritoButton.titleLabel?.font = .systemFont(ofSize: 24.0)
    }
    
    private func loadComics() {
        if let id = character?.id {
            loadingActivityIndicator.startAnimating()
            comicViewModel.loadComics(id: id)
        }
    }
    
    private func showDialog(message :String, title: String, status: RequestAPIStatusType) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            switch status {
            case .sucess:
                self.comicCollectionView.reloadData()
            case .error:
                self.navigationController?.popViewController(animated: true)
            }
        })
        
        dialogMessage.addAction(ok)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

extension ComicCollectionViewController : ComicDelegate {
    func sucessLoadComics(type: RequestAPIStatusType) {
        if loadingActivityIndicator.isAnimating {
            loadingActivityIndicator.stopAnimating()
        }
        showDialog(message: "Quadrinhos carregados com sucesso!", title: "Sucesso", status: .sucess)
    }
    
    func errorLoadComics(type: RequestAPIStatusType) {
        if loadingActivityIndicator.isAnimating {
            loadingActivityIndicator.stopAnimating()
        }
        showDialog(message: "Erro ao carregar os quadrinhos, favor selecionar outro personagem.", title: "Erro", status: .error)
    }
}

extension ComicCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: comicViewModel.getComicList()[indexPath.row])
    }
}

extension ComicCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicViewModel.getComicList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comicCell", for: indexPath) as? ComicCollectionViewCell {
            cell.setup(with: comicViewModel.getComicList()[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ComicCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            if searchText.isEmpty {
                loadComics()
            } else {
                comicViewModel.searchComics(searchText: searchText)
                comicCollectionView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadComics()
    }
}
