//
//  ViewController.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    let serviceLogin = ServiceLogin()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func actionLoginWithFacebook(_ sender: Any) {
        if serviceLogin.loginWithFacebookIsValid() {
            
        }
    }
    
    
    @IBAction func actionLoginWithGoogle(_ sender: Any) {
        if serviceLogin.loginWithGoogleIsValid(){
            
        }
    }
}

