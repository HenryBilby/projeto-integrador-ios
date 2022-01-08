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
    
    private func escondeCamposDeLogin() {

        emailTextField.isHidden = true
        passwordTextField.isHidden = true

        loginButton.isHidden = true
        resetSenhaButton.isHidden = true

        logoutButton.isHidden = false
    }
        private func revelaCamposDeLogin() {
            
            emailTextField.isHidden = false
            passwordTextField.isHidden = false
            
            loginButton.isHidden = false
            resetSenhaButton.isHidden = false
            
            logoutButton.isHidden = true
        }
    @IBAction func resetSenhaButton(_ sender: Any) {
        guard let email = emailTextField.text else { return }
                
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let error = error {
                        print("Erro ao resetar senha")
                        return
                    }
                    
                    print("email de resetar senha enviado com sucesso")
                }
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            revelaCamposDeLogin()
            print("Usuário efetuou logout com sucesso")

        } catch {
            print("Erro ao deslogar")
            
        }
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            guard error == nil else {
                self.criarNovaContaNoFirebase(email: email, password: password)
                self.performSegue(withIdentifier: "selectCharacterSegue", sender: email)
                return
            }
            
            print(" O usuário fez login com sucesso!")
            self.performSegue(withIdentifier: "selectCharacterSegue", sender: email)
            self.escondeCamposDeLogin()
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
              
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    
                    guard error == nil else {
                        print("Erro ao criar a conta")
                        return
                    }
                    
                    print("Sucesso na criação de conta e login efetuado!")
                    self.escondeCamposDeLogin()
                    
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
    
    func loginFirebase(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                print("<<<< Erro ao logar no Firebase \(error.localizedDescription)")
                return
            }
            
            if let user = Auth.auth().currentUser {
                self.performSegue(withIdentifier: "selectCharacterSegue", sender: user.displayName)
            }
        }
    }
    
    func logoutFirebase(){
        do {
            try Auth.auth().signOut()
            print("<<<< Usuario efetuou logout no firebase com sucesso")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selecteCharactersViewController = segue.destination as? SelectCharacterViewController, segue.identifier == "selectCharacterSegue" {
            selecteCharactersViewController.usuario = sender as? String
        }
    }
}

extension LoginViewController:LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        print("<<<< Usuario efetuou login no facebook")
        
        switch result {
        case .none:
            print("<<<< Erro ao efetuar login no Facebook")
        case .some(let loginResult):
            if let token = loginResult.token?.tokenString {
                print("<<<< Token is: \(token)")
                let credential = FacebookAuthProvider.credential(withAccessToken: token)
                loginFirebase(credential: credential)
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("<<<< Usuario efetuou logout no facebook")
        logoutFirebase()
    }
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser, withError error: Error!) {
            guard
                let authentication = user.authentication,
                let idToken = authentication.idToken else { return }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: authentication.accessToken
            )

            print("<<<< Usuario \(String(describing: user.profile.name)) efetuou login no Gmail")
            loginFirebase(credential: credential)
    }
}
