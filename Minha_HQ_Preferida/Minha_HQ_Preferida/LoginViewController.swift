//
//  ViewController.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//
import Foundation
import UIKit
import GoogleSignIn
import Firebase

class LoginViewController: UIViewController {
    
    let loginViewModel = LoginViewModel()

        @IBOutlet var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    @IBAction func actionLoginWithFacebook(_ sender: Any) {
        if loginViewModel.loginWithFacebookIsValid() {
            performSegue(withIdentifier: "selectCharacterSegue", sender: sender)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectCharacterSegue" {
        }
    }
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser, withError error: Error!) {
        loginViewModel.loginWithGoogleIsValid()
        
            print(">>>>> Usuario logado no Firebase")
            self.performSegue(withIdentifier: "selectCharacterSegue", sender: nil)
        }
    }
