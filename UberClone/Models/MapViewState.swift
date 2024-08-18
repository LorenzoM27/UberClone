//
//  MapViewState.swift
//  UberClone
//
//  Created by Lorenzo Menino on 17/08/2024.
//

import Foundation

// enum permet de garder un meilleur code, sclalable et maintenable
// pour nous permettre de manage les mapStates
// Notre map va avoir plusieurs états différents, pour les gérer plus facilement, un enum est recommandé

enum MapViewState {
    case noInpute
    case searchingForLocation
    case locationSelected
}
