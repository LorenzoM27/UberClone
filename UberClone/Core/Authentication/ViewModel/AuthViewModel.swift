//
//  AuthViewModel.swift
//  UberClone
//
//  Created by Lorenzo Menino on 01/09/2024.
//

import Foundation
import FirebaseAuth


class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User? // On va stocker les infos de l'user actuellement connecté, si pas connecté alors variable vide donc on montre la page de connexion
    
    init() {
        userSession = Auth.auth().currentUser // Si on a un user connecté c'est l'a qu'on l'obtient de firebase, si c'est pas le cas nous renvoit nil
    }
    
    func signIn(withEmail email: String, password : String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            self.userSession = result?.user
        }
    }
    
    func registerUser(withEmail email: String, password: String, fullname: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign up with error \(error.localizedDescription)")
                return
            }
            self.userSession = result?.user
        }
    }
  
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch let error {
            print("DEBUG: Failed to signOut with error : \(error.localizedDescription)")
        }
    }
}
