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
    
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonResetSenha: UIButton!
    @IBOutlet weak var buttonCriarConta: UIButton!
    
    @IBOutlet weak var facebookButtonContainer: UIView!

    @IBOutlet var signInButton: GIDSignInButton!
    
    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGoogleButtonBehavior()
        setFacebookButtonBehavior()
        setButtonsRadius()
        
        loginViewModel.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selecteCharactersViewController = segue.destination as? SelectCharacterViewController, segue.identifier == "selectCharacterSegue" {
            selecteCharactersViewController.usuario = sender as? String
        }
    }

    @IBAction func resetSenhaButton(_ sender: Any) {
        if loginViewModel.isValid(textField: textFieldEmail) {
            removeError(textField: textFieldEmail)
            loginViewModel.resetPassword(with: textFieldEmail.text!)
        } else {
            showError(textField: textFieldEmail)
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

    private func setButtonsRadius() {
        let radius : CGFloat = 10
        buttonLogin.layer.cornerRadius = radius
        buttonCriarConta.layer.cornerRadius = radius
        buttonResetSenha.layer.cornerRadius = radius
    }
    
    private func setGoogleButtonBehavior() {
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    private func setFacebookButtonBehavior() {
        let facebookButton = FBLoginButton(frame: facebookButtonContainer.bounds, permissions: [.publicProfile])
        facebookButton.delegate = self
        self.facebookButtonContainer.backgroundColor = .clear
        self.facebookButtonContainer.addSubview(facebookButton)
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
        let message = "O campo marcado de vermelho não pode estar vazio"
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
    
    private func showDialogWithHandler(with message: String) {
        let alert = UIAlertController(title: "Minha HQ Preferida APP", message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(
            title: "Continuar",
            style: .default) {[weak self] _ in
                guard let self = self else {return}
                self.goToNextScreen(with: nil)
            }
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func criarNovaContaNoFirebase(email: String, password: String) {
        
        let alert = UIAlertController(
            title: "Minha HQ Preferia APP",
            message: "Você deseja criar uma nova conta?",
            preferredStyle: .alert
        )
        
        let continuarAction = UIAlertAction(
            title: "Continuar",
            style: .default) {[weak self] _ in
                guard let self = self else {return}
                self.loginViewModel.createUser(with: email, with: password)
            }
        
        let cancelarAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(continuarAction)
        alert.addAction(cancelarAction)
        
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
                loginViewModel.loginFirebase(credential: credential)
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

            loginViewModel.loginFirebase(credential: credential)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func createUserWithSucess(userEmail: String) {
        let message = "Sucesso: Usuário criado com o \(userEmail)"
        showDialogWithHandler(with: message)
    }
    
    func operationWithError(errorMessage: String) {
        showDialog(with: errorMessage)
    }
    
    func resetPasswordWithSucess(userEmail: String) {
        let message = "Sucesso: Favor acessar o \(userEmail) para redefinir sua senha"
        showDialog(with: message)
    }

    func loginWithSucess(userName: String?) {
        goToNextScreen(with: userName)
    }
    
}
