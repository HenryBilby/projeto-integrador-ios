//
//  LoginViewModel.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import Foundation
import Firebase
import UIKit

protocol LoginViewModelDelegate {
    func loginComSucesso(userName: String?)
    func loginComErro(errorMessage: String)
}

class LoginViewModel {
    
    public var delegate : LoginViewModelDelegate?
    private let serviceLogin = LoginService()
    
    public func loginFirebase(credential: AuthCredential) -> User? {
        return serviceLogin.loginFirebase(credential: credential)
    }
    
    public func logoutFirebase() {
        serviceLogin.logoutFirebase()
    }
    
    public func isValid(textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    public func loginFirebase(email: String, password: String) {
        serviceLogin.loginFirebase(with: email, with: password) { result in
            if let user = result.user {
                DispatchQueue.main.async {
                    self.delegate?.loginComSucesso(userName: user.displayName)
                }
            } else {
                var message = ""
                
                switch result.error {
                case .invalidEmail:
                    message = "E-mail inválido"
                    break
                case .invalidPassword:
                    message = "Senha inválida"
                    break
                default:
                    message = "Erro ao realizar login!"
                    break
                }
                
                DispatchQueue.main.async {
                    self.delegate?.loginComErro(errorMessage: message)
                }
            }
        }
    }
}
