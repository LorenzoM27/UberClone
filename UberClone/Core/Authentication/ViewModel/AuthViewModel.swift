//
//  AuthViewModel.swift
//  UberClone
//
//  Created by Lorenzo Menino on 01/09/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User? // On va stocker les infos de l'user actuellement connecté, si pas connecté alors variable vide donc on montre la page de connexion
    @Published var currentUser: User?
    
    init() {
        userSession = Auth.auth().currentUser // Si on a un user connecté c'est l'a qu'on l'obtient de firebase, si c'est pas le cas nous renvoit nil
        fetchuser()
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
            guard let firebaseUser = result?.user else { return }
            self.userSession = firebaseUser
            
            // encode informations and send them to firebase
            let user = User(fullname: fullname, email: email, uid: firebaseUser.uid)
            
            guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
            
            Firestore.firestore().collection("users").document(firebaseUser.uid).setData(encodedUser)
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
    
    func fetchuser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //guard let uid = self.userSession?.uid else { return } // l'un ou l'autre, celle ci utilise notre variable
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let data = snapshot?.data() else { return }
            
            guard let user = try? snapshot?.data(as: User.self) else { return }
            
            self.currentUser = user
        }
    }
}
