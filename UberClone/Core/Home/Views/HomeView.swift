//
//  HomeView.swift
//  UberClone
//
//  Created by Lorenzo Menino on 31/07/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        UberMapViewRepresentable()
            .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
