//
//  ServiceLogin.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import Foundation
import Firebase

class LoginService {
    
    public func loginFirebase(credential: AuthCredential) -> User? {

        var user : User?

        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                print("<<<< Erro ao logar no Firebase \(error.localizedDescription)")
                return
            }

            user = Auth.auth().currentUser
        }

        return user
    }
    
    public func logoutFirebase(){
        do {
            try Auth.auth().signOut()
            print("<<<< Usuario efetuou logout no firebase com sucesso")
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
