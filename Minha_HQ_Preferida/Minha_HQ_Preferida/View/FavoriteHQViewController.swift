//
//  FavoriteHQViewController.swift
//  Minha_HQ_Preferida
//
//  Created by Paula Matsumoto on 17/11/21.
//

import UIKit

class FavoriteHQViewController: UIViewController {
    
    @IBOutlet weak var listaHQ: UILabel!
    @IBOutlet weak var voltarBtn: UIButton!
    @IBOutlet weak var hqFavoritaTableView: UITableView!
    
    @IBOutlet weak var hqFavoritaCollectionView: UICollectionView!
    
    let viewModel: FavoritoViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hqFavoritaTableView.delegate = self
        hqFavoritaTableView.dataSource = self
        
        viewModel.delegate = self
        viewModel.carregaDados()
        setButtonRadius()
        
        setTableView()
        setButtonRadius()
        setLabelRadius()
        setCollectionView()
    }
    
    @IBAction func close(_ sender: Any) {
    dismiss(animated: true)
    }
    
    private func setTableView(){
        hqFavoritaTableView.layer.cornerRadius = 16
        hqFavoritaTableView.layer.masksToBounds = true
    }
    
    private func setCollectionView() {
        hqFavoritaCollectionView.layer.cornerRadius = 32
        hqFavoritaCollectionView.layer.masksToBounds = true
    }
    
    private func setButtonRadius() {
        voltarBtn.layer.cornerRadius = 32
        voltarBtn.layer.masksToBounds = true
    }
    
    private func setLabelRadius() {
        listaHQ.layer.cornerRadius = 32
        listaHQ.layer.masksToBounds = true
    }
}

extension FavoriteHQViewController: FavoritoViewModelDelegate {
    func recarregaDados() {
        hqFavoritaTableView.reloadData()
    }
}

extension FavoriteHQViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.quantidadeDeFavoritosNaLista()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavoritoTableViewCell {
            let favorito = viewModel.favorito[indexPath.row]
            guard let nome = favorito.nome else { return .init()}
            
            cell.setup(nome: nome, imagem: favorito.imagem ?? "")
            return cell
        }
        return .init()
    }
}

extension FavoriteHQViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel.removerFavorito(em: indexPath.row)
    }

}
