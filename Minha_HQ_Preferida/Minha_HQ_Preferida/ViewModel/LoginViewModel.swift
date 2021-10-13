//
//  LoginViewModel.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import Foundation

class LoginViewModel {
    
    let serviceLogin = ServiceLogin()
    
    public func loginWithFacebookIsValid() -> Bool {
        return serviceLogin.loginWithFacebookIsValid()
    }
    
    public func loginWithGoogleIsValid() -> Bool {
        return serviceLogin.loginWithGoogleIsValid()
    }
}
