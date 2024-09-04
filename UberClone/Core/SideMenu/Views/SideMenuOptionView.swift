//
//  SideMenuOptionView.swift
//  UberClone
//
//  Created by Lorenzo Menino on 03/09/2024.
//

import SwiftUI

struct SideMenuOptionView: View {
    
    let viewModel: SideMenuOptionViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: viewModel.imageName)
                .font(.title)
                .imageScale(.medium)
            
            Text(viewModel.title)
                .font(.system(size: 16, weight: .semibold))
            
            Spacer()
            
        }
        .foregroundStyle(Color.theme.primaryTextColor)
    }
}

#Preview {
    SideMenuOptionView(viewModel: .trips)
}
