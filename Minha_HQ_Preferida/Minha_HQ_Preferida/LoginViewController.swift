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
import FacebookCore
import FacebookLogin


class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var senhaLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var resetSenhaButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var facebookButtonContainer: UIView!
    
    let loginViewModel = LoginViewModel()

        @IBOutlet var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        
        let facebookButton = FBLoginButton(frame: facebookButtonContainer.bounds, permissions: [.publicProfile])
                
        facebookButton.delegate = self
                
        self.facebookButtonContainer.backgroundColor = .clear
                
        self.facebookButtonContainer.addSubview(facebookButton)
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
//                guard let self = self else { return }
              
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
    
    func loginFacebookNoFirebase(acessToken: String) {
            let credential = FacebookAuthProvider.credential(withAccessToken: acessToken)
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("Deu erro ao logar no Firebase \(error.localizedDescription)")
                    return
                }
                
                print("Usuario efetuou login no firebase: ")
                
                if let user = Auth.auth().currentUser {
                    print("O usuario do firebase é: \(user)")
                }
            }
            
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectCharacterSegue" {
        }
    }
}

extension LoginViewController:LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        print("<<<< Usuario efetuou login no facebook")
        
        switch result {
        case .none:
            print("<<<< um erro aconteceu")
        case .some(let loginResult):
            print("<<<< loginResult: ")
            print(loginResult.grantedPermissions)
            print(loginResult.declinedPermissions)
            print(loginResult.isCancelled)
            
//            self.performSegue(withIdentifier: "selectCharacterSegue", sender: nil)
            
            if let token = loginResult.token?.tokenString {
                print("Token is: \(token)")
                loginFacebookNoFirebase(acessToken: token)
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("<<<< Usuario efetuou logout no facebook")
        
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error.localizedDescription)
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
