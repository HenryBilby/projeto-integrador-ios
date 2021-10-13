//
//  ViewController.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func actionLoginWithFacebook(_ sender: Any) {
        if loginViewModel.loginWithFacebookIsValid() {
            performSegue(withIdentifier: "selectCharacterSegue", sender: sender)
        }
    }
    
    
    @IBAction func actionLoginWithGoogle(_ sender: Any) {
        if loginViewModel.loginWithGoogleIsValid(){
            performSegue(withIdentifier: "selectCharacterSegue", sender: sender)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectCharacterSegue" {
            
        }
    }
}

