//
//  FirebaseService.swift
//  Minha_HQ_Preferida
//
//  Created by Paula Matsumoto on 07/12/21.
//

import Foundation
import Firebase
import GoogleSignIn

class FirebaseService {
    
    func efetuarLoginService(user: GIDGoogleUser, completion: @escaping (Bool) -> Void) {
        guard
            let authentication = user.authentication,
            let idToken = authentication.idToken else { return }
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: authentication.accessToken
        )
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error { return }
            completion(true)
        }
    }
    
    func deslogarDoFirebase() -> Bool {
        do {
            try Auth.auth().signOut()
            print(">>>>> Usuário fez logout")
            return true
        } catch {
            print(">>>>> Erro ao fazer logout")
            return false
        }
    }
}
