//
//  RideRequestView.swift
//  UberClone
//
//  Created by Lorenzo Menino on 18/08/2024.
//

import SwiftUI

struct RideRequestView: View {
    @State private var selectedRideType: RideType = .uberX
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    var body: some View {
        VStack {
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            // Trip info view
            HStack {
                
                // Indicator view
                VStack {
                    
                  Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 8)
                    
                    Rectangle()
                          .fill(Color(.systemGray3))
                          .frame(width: 1, height: 32)
                    
                    Rectangle()
                        .fill(.black)
                          .frame(width: 8, height: 8)
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Text("Ma position")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.gray)
                        
                        Spacer()
                        
                        Text(locationViewModel.pickupTime ?? "")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.gray)
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        if let location = locationViewModel.selectedUberLocation {
                            Text(location.title)
                                .font(.system(size: 16, weight: .semibold))
                        }
                        
                        Spacer()
                        
                        Text(locationViewModel.dropOffTime ?? "")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.leading, 8)
            }
            .padding()
            
            Divider()
            
            // ride type selection view
            Text("CHOISISSEZ UNE COURSE")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(RideType.allCases) { type in
                        VStack(alignment: .leading) {
                            Image(type.imageName)
                                .resizable()
                                .scaledToFit()
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(type.description)
                                    .font(.system(size: 14, weight: .semibold))
                                
                                Text(locationViewModel.computeRidePrice(forType: type).toCurrency() )
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding()
                        }
                        .frame(width: 112, height: 140)
                        .foregroundStyle(Color(type == selectedRideType ? .white : Color.theme.primaryTextColor))
                        .background(type == selectedRideType ? .blue : Color.theme.secondaryBackgroundColor)
                        .scaleEffect(type == selectedRideType ? 1.2 : 1.0)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            withAnimation(.spring) {
                                selectedRideType = type
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Divider()
                .padding(.vertical, 8)
            
            // payment option view
            HStack(spacing: 12) {
                Text("VISA")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .foregroundStyle(.white)
                    .padding(.leading)
                
                Text("***** 123")
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height: 50)
            .background(Color.theme.secondaryBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
            
            // request ride button
            
            Button {
                
            } label: {
                Text("CONFIRMER LA COURSE")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32 ,height: 50)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.white)
            }
        }
        .padding(.bottom, 24)
        .background(Color.theme.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    RideRequestView()
}
