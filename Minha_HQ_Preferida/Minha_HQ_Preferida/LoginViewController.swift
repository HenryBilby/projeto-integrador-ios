//
//  ViewController.swift
//  Minha_HQ_Preferida
//
//  Created by Henry Bilby on 07/10/21.
//

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
        
        if saberSeUsuarioEstaLogadoNoFirebase() {
            deslogarDoFirebase()
        }
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
    
    func pegarDadosDoUsuarioLogado() {
        let firebaseAuth = Auth.auth()
        let usuarioAtual = firebaseAuth.currentUser
        
        guard let usuarioAtual = usuarioAtual  else { return }
        
        print(">>>>> Informações do usuário logado")
        print(">>>>> nome: \(usuarioAtual.displayName)")
        print(">>>>> email: \(usuarioAtual.email)")
        print(">>>>> foto: \(usuarioAtual.photoURL)")
        print(">>>>> phoneNumber: \(usuarioAtual.phoneNumber)")
    }
    
    func saberSeUsuarioEstaLogadoNoFirebase() -> Bool {
        let firebaseAuth = Auth.auth()
        let usuarioAtual = firebaseAuth.currentUser
        
        if usuarioAtual != nil {
            print(">>>>> Usuario está logado")
            pegarDadosDoUsuarioLogado()
            return true
        } else {
            print(">>>>> Usuario não está logado")
            return false
        }
    }
    
    func deslogarDoFirebase() {
        do {
            try Auth.auth().signOut()
            print(">>>>> Usuário fez logout")
        } catch {
            print(">>>>> Erro ao fazer logout")
        }
    }
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser, withError error: Error!) {
        print(">>>>> User email: \(user.profile.email)")
        
        guard
            let authentication = user.authentication,
            let idToken = authentication.idToken else { return }
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: authentication.accessToken
        )
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error { return }
            print(">>>>> Usuario logado no Firebase")
            self.pegarDadosDoUsuarioLogado()
            self.performSegue(withIdentifier: "selectCharacterSegue", sender: nil)
        }
    }
}

