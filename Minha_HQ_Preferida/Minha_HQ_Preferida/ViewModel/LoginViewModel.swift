//
//  LoginViewModel.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import Foundation
import Firebase
import GoogleSignIn

protocol LoginViewModelDelegate {
    func loginWithSucess(userName: String?)
    func operationWithError(errorMessage: String)
    func resetPasswordWithSucess(userEmail: String)
    func createUserWithSucess(userEmail: String)
}

class LoginViewModel {
    
    public var delegate : LoginViewModelDelegate?
    private let serviceLogin = LoginService()
    
    public func loginGoogle(user: GIDGoogleUser) {
        serviceLogin.loginGoogle(user: user) { [weak self] credential in
            guard let self = self else { return }
            self.loginFirebase(credential: credential)
        }
    }
    
    public func loginFirebase(credential: AuthCredential) {
        serviceLogin.loginFirebase(credential: credential) { result in
            if let user = result.user {
                self.getNameFromUser(user: user)
            } else if let error = result.error {
                self.operationWithError(error: error)
            }
        }
    }
    
    public func logout() {
        serviceLogin.logout()
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
                self.getNameFromUser(user: user)
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
    
    public func getUser(){
        if let user = Auth.auth().currentUser {
            getNameFromUser(user: user)
        }
    }
    
    private func getNameFromUser(user: User) {
        if let name = user.displayName {
            loginWithSucess(name: name)
        } else if let email = user.email{
            let name = getNameFromEmail(email: email)
            loginWithSucess(name: name)
        } else {
            loginWithSucess(name: nil)
        }
    }

    private func loginWithSucess(name: String?) {
        DispatchQueue.main.async {
            self.delegate?.loginWithSucess(userName: name)
        }
    }
    
    private func getNameFromEmail(email: String) -> String {
        let delimiter = "@"
        if let name = email.components(separatedBy: delimiter).first {
            return name
        }
        return ""
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
        case .weakPassword:
            message = "Senha muito fraca, escolha outra"
            break
        case .appVerificationUserInteractionFailure:
            message = "Erro na verificação do usuário, realizar login mais tarde"
            break
        case .emailAlreadyInUse:
            message = "E-mail já cadastrado, clica em esqueci a senha"
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
