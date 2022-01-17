//
//  LoginViewModel.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import Foundation
import Firebase

class LoginViewModel {
    
    private let serviceLogin = LoginService()
    
    public func loginFirebase(credential: AuthCredential) -> User? {
        return serviceLogin.loginFirebase(credential: credential)
    }
    
    public func logoutFirebase() {
        serviceLogin.logoutFirebase()
    }
}
