//
//  UberCloneApp.swift
//  UberClone
//
//  Created by Lorenzo Menino on 31/07/2024.
//

import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure() // Essentiel pour la communication avec le serveur, pour le backend
    return true
  }
}

@main
struct UberCloneApp: App {
    // On va utilsier cette instance seul, qu'on va pouvoir utilisé dans l'app
    @StateObject var locationViewModel = LocationSearchViewModel()
    @StateObject var authViewModel = AuthViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate // Pour implémenter firebase

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
                .environmentObject(authViewModel)
        }
    }
}
