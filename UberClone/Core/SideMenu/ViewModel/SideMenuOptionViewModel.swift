//
//  SideMenuOptionViewModel.swift
//  UberClone
//
//  Created by Lorenzo Menino on 03/09/2024.
//

import Foundation


enum SideMenuOptionViewModel: Int, CaseIterable, Identifiable {
    
    case trips
    case wallet
    case settings
    case messages
    
    var title: String {
        switch self {
        case .trips: return "Mes Voyages"
        case .wallet: return "Portefeuille"
        case .settings: return "Paramètres"
        case .messages: return "Messages"
            
        }
    }
    
    var imageName: String {
        switch self {
        case .trips: return "list.bullet.rectangle"
        case .wallet: return "creditcard"
        case .settings: return "gear"
        case .messages: return "bubble.left"
            
        }
    }
    
    var id: Int { return self.rawValue }
}
