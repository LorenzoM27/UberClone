//
//  Color.swift
//  UberClone
//
//  Created by Lorenzo Menino on 19/08/2024.
//

import Foundation
import SwiftUI


extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
    let primaryTextColor = Color("PrimaryTextColor")
    
}
