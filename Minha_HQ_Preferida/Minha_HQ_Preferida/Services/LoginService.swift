//
//  ServiceLogin.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import Foundation
import Firebase

enum FirebaseError : Error {
    case invalidEmail
    case invalidPassword
}

struct LoginResult {
    let user: User?
    let error: FirebaseError?
}

class LoginService {
    
    public func loginFirebase(credential: AuthCredential) -> User? {

        var user : User?

        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                print("<<<< Erro ao logar no Firebase com credencial: \(error.localizedDescription)")
                return
            }

            user = Auth.auth().currentUser
        }

        return user
    }
    
    public func loginFirebase(with email: String, with password: String, completion: @escaping (LoginResult) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            var user : User?
            var firebaseError : FirebaseError?
            
            if let error = error {
                print("<<<< Erro ao logar no Firebase com e-mail: \(error.localizedDescription)")
                
                let authErrorCode = AuthErrorCode(rawValue: error._code)
                
                switch authErrorCode {
                case .invalidEmail:
                    firebaseError = .invalidEmail
                    break
                case .wrongPassword:
                    firebaseError = .invalidPassword
                    break
                default:
                    break
                }
                
                completion(LoginResult(user: nil, error: firebaseError))
            }
            
            user = Auth.auth().currentUser
            completion(LoginResult(user: user, error: nil))
        }
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
