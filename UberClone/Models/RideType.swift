//
//  RideType.swift
//  UberClone
//
//  Created by Lorenzo Menino on 18/08/2024.
//

import Foundation

// CaseIterable permet de mettre toutes les cases dans un tableau, ce qui permet de looper dessus ensuite (forEach)
enum RideType: Int, CaseIterable, Identifiable {
    case uberX
    case black
    case uberXL
    
    var id: Int { return rawValue }
    
    var description: String {
        switch self {
        case .uberX: return "UberX"
        case .black: return "UberBlack"
        case .uberXL: return "UberXL"
        }
    }
    
    var imageName: String {
        switch self {
        case .uberX: return "uber-x"
        case .black: return "uber-black"
        case .uberXL: return "uber-x"
        }
    }
    
    var baseFare: Double {
        switch self {
        case .uberX: return 5
        case .black: return 20
        case .uberXL: return 10
        }
    }
    
    // on va calculer la distance entre la localisation de l'user et la destination et appler cette fonction pour créer le prix
    func computePrice(for distanceInMeters: Double) -> Double {
        
        switch self {
        case .uberX: return (distanceInMeters * 1.5 + baseFare)/1000
        case .black: return (distanceInMeters * 2 + baseFare)/1000
        case .uberXL: return (distanceInMeters * 1.75 + baseFare)/1000
        }
    }
}
