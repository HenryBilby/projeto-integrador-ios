//
//  UserInfoViewModel.swift
//  Minha_HQ_Preferida
//
//  Created by Paula Matsumoto on 07/12/21.
//

import Foundation
import UIKit


protocol UserInfoViewModelDelegate {
    func efetuaLogout()
}

class UserInfoViewModel {
    let service: FirebaseService = .init()
    var delegate: UserInfoViewModelDelegate?

    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
    
}
