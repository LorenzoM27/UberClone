//
//  LocationSearchView.swift
//  UberClone
//
//  Created by Lorenzo Menino on 15/08/2024.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var startLocationText = ""
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel : LocationSearchViewModel
    
    var body: some View {
        VStack {
            
            //HeaderView
            
            HStack {
                VStack {
                    
                  Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    
                    Rectangle()
                          .fill(Color(.systemGray3))
                          .frame(width: 1, height: 24)
                    
                    Rectangle()
                        .fill(.black)
                          .frame(width: 6, height: 6)
                }
                
                VStack {
                    TextField("Lieu de prise en charge", text: $startLocationText)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                    
                    // ON lie se textre field avec le queryFragment
                    TextField("Où allez-vous ?", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top, 64)
           
            Divider()
                .padding(.vertical)
            // list view
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.results, id: \.self) { result in
                        LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                            .onTapGesture {
                                withAnimation(.spring) {
                                    viewModel.selectedLocation(result)
                                    mapState = .locationSelected
                                }
                            }
                    }
                }
            }
        }
        .background(Color.theme.backgroundColor)
    }
}

//#Preview {
//    LocationSearchView(mapState: .constant(.searchingForLocation))
//}
