//
//  LoginViewModel.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import Foundation

class LoginViewModel {
    
    let serviceLogin = LoginService()
    
    public func loginWithFacebookIsValid() -> Bool {
        return serviceLogin.facebookLoginIsValid()
    }
    
    public func loginWithGoogleIsValid() -> Bool {
        return serviceLogin.googleLoginIsValid()
    }
}
