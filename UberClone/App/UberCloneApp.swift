//
//  UberCloneApp.swift
//  UberClone
//
//  Created by Lorenzo Menino on 31/07/2024.
//

import SwiftUI

@main
struct UberCloneApp: App {
    // On va utilsier cette instance seul, qu'on va pouvoir utilisé dans l'app
    @StateObject var locationViewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
