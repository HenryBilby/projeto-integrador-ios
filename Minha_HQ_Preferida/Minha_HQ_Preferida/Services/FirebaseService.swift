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
    func pegarDadosDoUsuarioLogado() {
        let firebaseAuth = Auth.auth()
        let usuarioAtual = firebaseAuth.currentUser
        
        guard let usuarioAtual = usuarioAtual  else { return }
        
        print(">>>>> Informações do usuário logado")
        print(">>>>> nome: \(usuarioAtual.displayName)")
        print(">>>>> email: \(usuarioAtual.email)")
        print(">>>>> foto: \(usuarioAtual.photoURL)")
        print(">>>>> phoneNumber: \(usuarioAtual.phoneNumber)")
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

