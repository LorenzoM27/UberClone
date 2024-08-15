//
//  LocationSearchActivationView.swift
//  UberClone
//
//  Created by Lorenzo Menino on 15/08/2024.
//

//


import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        HStack {
            
            Rectangle()
                .fill(Color.black)
                .frame(width: 8, height: 8)
                .padding(.horizontal)
            
            Text("Où allez vous ?")
                .foregroundStyle(Color(.darkGray))
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64, height : 50)
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(color: .black, radius: 6)
        )
    }
}

#Preview {
    LocationSearchActivationView()
}
