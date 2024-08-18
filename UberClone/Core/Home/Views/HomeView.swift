//
//  HomeView.swift
//  UberClone
//
//  Created by Lorenzo Menino on 31/07/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState = MapViewState.noInpute // alternative a plein d'autres states
    
    var body: some View {
        ZStack(alignment: .top) {
            UberMapViewRepresentable(mapState: $mapState)
                .ignoresSafeArea()
            
            
            if mapState == .searchingForLocation {
                LocationSearchView(mapState: $mapState)
            } else if mapState == .noInpute {
                LocationSearchActivationView()
                    .padding(.top, 72)
                    .onTapGesture {
                        withAnimation(.spring) {
                            mapState = .searchingForLocation
                        }
                    }
            }
            
            
            MapViewActionButton(mapState: $mapState)
                .padding(.leading)
                .padding(.top, 4)
        }
    }
}

#Preview {
    HomeView()
}
