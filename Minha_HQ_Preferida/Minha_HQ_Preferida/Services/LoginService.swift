//
//  ServiceLogin.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import Foundation
import Firebase
import FacebookCore
import FacebookLogin
import GoogleSignIn

struct LoginResult {
    let user: User?
    let error: AuthErrorCode?
}

class LoginService {
    
    public func loginGoogle(user: GIDGoogleUser, completion: @escaping (AuthCredential) -> Void){
        guard
            let authentication = user.authentication,
            let idToken = authentication.idToken else { return }
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: authentication.accessToken
        )

        completion(credential)
    }
    
    public func loginFirebase(credential: AuthCredential, completion: @escaping (LoginResult) -> Void){
        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                print("<<<< Erro ao logar no Firebase com credencial: \(error.localizedDescription)")
                let authErrorCode = AuthErrorCode(rawValue: error._code)
                completion(LoginResult(user: nil, error: authErrorCode))
            }

            let user = Auth.auth().currentUser
            completion(LoginResult(user: user, error: nil))
        }
    }
    
    public func loginFirebase(with email: String, with password: String, completion: @escaping (LoginResult) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("<<<< Erro ao logar no Firebase com e-mail: \(error.localizedDescription)")
                
                let authErrorCode = AuthErrorCode(rawValue: error._code)
                completion(LoginResult(user: nil, error: authErrorCode))
            }
            
            let user = Auth.auth().currentUser
            completion(LoginResult(user: user, error: nil))
        }
    }
    
    public func logoutFirebase(){
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    public func resetPassword(with email: String, completion: @escaping (AuthErrorCode?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Erro ao resetar senha: \(error.localizedDescription)")

                let authErrorCode = AuthErrorCode(rawValue: error._code)
                completion(authErrorCode)
            }

            completion(nil)
        }
    }
    
    public func createUser(with email: String, with password: String, completion: @escaping (AuthErrorCode?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if let error = error {
                print("Erro ao criar usuário: \(error.localizedDescription)")

                let authErrorCode = AuthErrorCode(rawValue: error._code)
                completion(authErrorCode)
            }
            
            print("Sucesso na criação de conta e login efetuado!")
            completion(nil)
        }
    }
}
