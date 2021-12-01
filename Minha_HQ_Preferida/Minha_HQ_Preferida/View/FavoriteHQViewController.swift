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
    
    let viewModel: FavoritoViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hqFavoritaTableView.dataSource = self
        
        viewModel.delegate = self
        viewModel.carregaDados()
        
        setTableView()
        setButtonRadius()
        setLabelRadius()
    }
    
    @IBAction func close(_ sender: Any) {
    dismiss(animated: true)
    }
    
    private func setTableView(){
        hqFavoritaTableView.layer.cornerRadius = 32
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
