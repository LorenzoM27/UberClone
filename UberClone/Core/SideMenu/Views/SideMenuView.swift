//
//  SideMenuView.swift
//  UberClone
//
//  Created by Lorenzo Menino on 03/09/2024.
//

import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    private let user: User
    // to build this view, we need to add an user
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        
            VStack(spacing: 40) {
                // header view
                VStack(alignment: .leading, spacing: 32){
                    // User info
                    HStack {
                        Image("male-profile-photo")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 64, height: 64)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(user.fullname)
                                .font(.system(size: 16, weight: .semibold))
                            
                            Text(user.email)
                                .font(.system(size: 14))
                                .accentColor(Color.theme.primaryTextColor)
                                .opacity(0.77)
                        }
                    }
                    
                    // become a driver
                    VStack(alignment: .leading ,spacing: 16) {
                        Text("Aller plus loin")
                            .font(.footnote)
                        .fontWeight(.semibold)
                        
                        HStack{
                            Image(systemName: "dollarsign.square")
                                .font(.title2)
                                .imageScale(.medium)
                            
                            Text("Gagner de l'argent en conduisant")
                                .font(.system(size: 16, weight: .semibold))
                                .padding(6)
                        }
                        
                    }
                    
                    Rectangle()
                        .frame(width: 296, height: 0.75)
                        .opacity(0.7)
                        .foregroundStyle(Color(.separator))
                        .shadow(color: .black.opacity(0.7), radius: 4)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading) // Tout aligner à gauche
                .padding(.leading, 16)
                // Option list
                VStack {
                    ForEach(SideMenuOptionViewModel.allCases) { viewModel in
                        NavigationLink(value: viewModel) {
                            SideMenuOptionView(viewModel: viewModel)
                                 .padding()
                        }
                    }
                }
                .navigationDestination(for: SideMenuOptionViewModel.self) { viewModel in
                    Text(viewModel.title)
                }
                
                Spacer()
                
                Button {
                    viewModel.signOut()
                } label: {
                    Text("DÉCONNEXION")
                        .foregroundStyle(.white)
                        .frame(width: 250, height: 50)
                        .background(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

                Spacer()
            
           
        }
        .padding(.top, 32)
        .background(Color.theme.backgroundColor)
    }
}

#Preview {
    SideMenuView(user: User(fullname: "test",
                            email: "test@gmail.com",
                            uid: "123345"))
}
