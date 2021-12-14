//
//  FavoriteHQViewController.swift
//  Minha_HQ_Preferida
//
//  Created by Paula Matsumoto on 17/11/21.
//

import UIKit

class FavoriteHQViewController: UIViewController {
    
    
    @IBOutlet weak var hqFavoritaTableView: UITableView!
    @IBOutlet weak var nomeTelaLabel: UILabel!
    @IBOutlet weak var voltarButton: UIButton!
    
    
    let viewModel: FavoritoViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hqFavoritaTableView.delegate = self
        hqFavoritaTableView.dataSource = self
        viewModel.delegate = self
        viewModel.carregaDados()
        setButtonRadius()
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
    
    private func setButtonRadius() {
        voltarButton.layer.cornerRadius = 32
        nomeTelaLabel.layer.cornerRadius = 32
    }
}
