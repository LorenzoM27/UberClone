//
//  HomeView.swift
//  UberClone
//
//  Created by Lorenzo Menino on 31/07/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState = MapViewState.noInpute // alternative a plein d'autres states
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
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
            
            if mapState == .locationSelected || mapState == .polylineAdded {
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .onReceive(LocationManager.shared.$userLocation, perform: { location in
            if let location = location {
                locationViewModel.userLocation = location
            }
        })
    }
}

#Preview {
    HomeView()
}
