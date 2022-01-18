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
    func loginWithSucess(userName: String?)
    func operationWithError(errorMessage: String)
    func resetPasswordWithSucess(userEmail: String)
    func createUserWithSucess(userEmail: String)
}

class LoginViewModel {
    
    public var delegate : LoginViewModelDelegate?
    private let serviceLogin = LoginService()
    
    public func loginFirebase(credential: AuthCredential) {
        serviceLogin.loginFirebase(credential: credential) { result in
            if let user = result.user {
                self.loginWithSucess(user: user)
            } else if let error = result.error {
                self.operationWithError(error: error)
            }
        }
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
                self.loginWithSucess(user: user)
            } else if let error = result.error {
                self.operationWithError(error: error)
            }
        }
    }

    public func resetPassword(with email: String) {
        serviceLogin.resetPassword(with: email) { error in
            if let error = error {
                self.operationWithError(error: error)
            } else {
                DispatchQueue.main.async {
                    self.delegate?.resetPasswordWithSucess(userEmail: email)
                }
            }
        }
    }
    
    public func createUser(with email: String, with password: String) {
        serviceLogin.createUser(with: email, with: password) { error in
            if let error = error {
                self.operationWithError(error: error)
            } else {
                DispatchQueue.main.async {
                    self.delegate?.createUserWithSucess(userEmail: email)
                }
            }
        }
    }

    private func loginWithSucess(user: User) {
        DispatchQueue.main.async {
            self.delegate?.loginWithSucess(userName: user.displayName)
        }
    }

    private func operationWithError(error: AuthErrorCode) {
        var message = ""

        switch error {
        case .invalidUserToken:
            message = "Erro de token: Necessário realizar o login novamente"
            break
        case .invalidCredential:
            message = "Erro de credencial: Necessário realizar o login novamente"
            break
        case .invalidEmail:
            message = "E-mail inválido"
            break
        case .wrongPassword:
            message = "Senha inválida"
            break
        case .userNotFound:
            message = "Usuário não encontrado, favor criar uma conta"
            break
        default:
            message = "Erro ao realizar login!"
            break
        }

        DispatchQueue.main.async {
            self.delegate?.operationWithError(errorMessage: message)
        }
    }
}
