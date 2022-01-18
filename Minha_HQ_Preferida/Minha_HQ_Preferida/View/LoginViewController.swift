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
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var resetSenhaButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var facebookButtonContainer: UIView!

    @IBOutlet var signInButton: GIDSignInButton!
    
    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        
        let facebookButton = FBLoginButton(frame: facebookButtonContainer.bounds, permissions: [.publicProfile])
                
        facebookButton.delegate = self
                
        self.facebookButtonContainer.backgroundColor = .clear
                
        self.facebookButtonContainer.addSubview(facebookButton)
        
        loginViewModel.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func resetSenhaButton(_ sender: Any) {
        guard let email = textFieldEmail.text else { return }
                
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let error = error {
                        print("Erro ao resetar senha")
                        return
                    }
                    
                    print("email de resetar senha enviado com sucesso")
                }
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        if isValidSignIn() {
            loginViewModel.loginFirebase(email: textFieldEmail.text!, password: textFieldPassword.text!)
        }
    }
    
    @IBAction func criarButton(_ sender: Any) {
        if isValidSignIn() {
            criarNovaContaNoFirebase(email: textFieldEmail.text!, password: textFieldPassword.text!)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selecteCharactersViewController = segue.destination as? SelectCharacterViewController, segue.identifier == "selectCharacterSegue" {
            selecteCharactersViewController.usuario = sender as? String
        }
    }

    private func goToNextScreen(with userName: String?) {
        self.performSegue(withIdentifier: "selectCharacterSegue", sender: userName)
    }
    
    private func isValidSignIn() -> Bool {
        if !loginViewModel.isValid(textField: textFieldEmail) {
            showError(textField: textFieldEmail)
            return false
        }
        
        if !loginViewModel.isValid(textField: textFieldPassword) {
            showError(textField: textFieldPassword)
            return false
        }
        
        removeErrorsFromTextFields()
        
        return true
    }
    
    private func showError(textField: UITextField){
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 2
        let message = "Corrigir o campo marcado de vermelho"
        showDialog(with: message)
    }
    
    private func removeErrorsFromTextFields() {
        removeError(textField: textFieldEmail)
        removeError(textField: textFieldPassword)
    }
    
    private func removeError(textField: UITextField){
        if textField.layer.borderColor == UIColor.red.cgColor {
            textField.layer.borderColor = UIColor.clear.cgColor
            textField.layer.borderWidth = 0
        }
    }
    
    private func showDialog(with message: String){
        let alert = UIAlertController(title: "Minha HQ Preferida APP", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
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

                let user = loginViewModel.loginFirebase(credential: credential)
                goToNextScreen(with: user?.displayName)
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("<<<< Usuario efetuou logout no facebook")
        loginViewModel.logoutFirebase()
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

            let user = loginViewModel.loginFirebase(credential: credential)
        goToNextScreen(with: user?.displayName)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func loginComSucesso(userName: String?) {
        goToNextScreen(with: userName)
    }
    
    func loginComErro(errorMessage: String) {
        showDialog(with: errorMessage)
    }
}
