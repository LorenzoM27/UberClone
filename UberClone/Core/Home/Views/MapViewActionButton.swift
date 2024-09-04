//
//  MapViewActionButton.swift
//  UberClone
//
//  Created by Lorenzo Menino on 15/08/2024.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapState: MapViewState
    @Binding var showSideMenu: Bool
    @EnvironmentObject var viewModel: LocationSearchViewModel
    @EnvironmentObject var authViewwModel: AuthViewModel
    
    var body: some View {
        Button {
            withAnimation(.spring) {
                actionForState(mapState)
            }
        } label: {
            Image(systemName: imageNameForState(mapState))
                .font(.title2)
                .foregroundStyle(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius:6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func actionForState(_ state: MapViewState) {
        switch state {
        case .noInpute:
            showSideMenu.toggle()
        case .searchingForLocation:
            mapState = .noInpute
        case .locationSelected, .polylineAdded:
            mapState = .noInpute
            viewModel.selectedUberLocation = nil
        }
    }
    
    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
        case .noInpute:
            return "line.3.horizontal"
        case .searchingForLocation, .locationSelected, .polylineAdded:
            return "arrow.left"
        default:
            return "line.3.horizontal"
        }
    }
}

#Preview {
    MapViewActionButton(mapState: .constant(.noInpute), showSideMenu: .constant(false))
}
