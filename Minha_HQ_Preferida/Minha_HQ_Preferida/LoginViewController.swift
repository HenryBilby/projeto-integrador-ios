//
//  ViewController.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//
import Foundation
import UIKit
import GoogleSignIn
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var senhaLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var resetSenhaButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    let loginViewModel = LoginViewModel()

        @IBOutlet var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            guard error == nil else {
                self.criarNovaContaNoFirebase(email: email, password: password)
                return
            }
            
            print(" O usuário fez login com sucesso!")

        }
    }
    
    func criarNovaContaNoFirebase(email: String, password: String) {
        
        let alert = UIAlertController(
            title: "Criar uma nova conta",
            message: "Você deseja criar uma nova conta?",
            preferredStyle: .alert
        )
        
        let continuarAction = UIAlertAction(
            title: "Continuar",
            style: .default) { _ in
                guard let self = self else { return }
              
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    
                    guard error == nil else {
                        print("Erro ao criar a conta")
                        return
                    }
                    
                    print("Sucesso na criação de conta e login efetuado!")
        
                    
                }
            }
        
        let cancelarAction = UIAlertAction(
            title: "Cancelar",
            style: .cancel) { _ in
                // retornar
            }
        
        alert.addAction(continuarAction)
        alert.addAction(cancelarAction)
        
        present(alert, animated: true, completion: nil)
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
