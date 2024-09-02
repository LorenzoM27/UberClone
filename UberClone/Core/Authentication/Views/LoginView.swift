//
//  LoginView.swift
//  UberClone
//
//  Created by Lorenzo Menino on 31/08/2024.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    
                    // Image and title
                    
                    VStack(spacing: -16) {
                        Image("uber-app-icon")
                            .resizable()
                            .frame(width: 200, height: 200)
                        
                        Text("UBER")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                    }
                    
                    // Input fields
                    
                    VStack(spacing: 32) {
                        // Input field 1
                        CustomInputField(text: $email, title: "Adresse email",
                                         placeholder: "nom@exemple.com")
                        
                        // Input field 2
                        CustomInputField(text: $password, title: "Mot de passe",
                                         placeholder: "Entrez votre mot de passe",
                                         isSecureField: true)
                        
                        Button {
                            
                        } label: {
                            Text("Mot de passe oublié ?")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(.white)
                                .padding(.top)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    // Social sign view
                    
                    VStack {
                        // Dividers + text
                        HStack(spacing: 24) {
                            Rectangle()
                                .frame(width: 76, height: 1)
                                .foregroundStyle(.white)
                                .opacity(0.5)
                            
                            Text("Se connecter avec")
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                            
                            Rectangle()
                                .frame(width: 76, height: 1)
                                .foregroundStyle(.white)
                                .opacity(0.5)
                        }
                        // Sign up buttons
                        HStack(spacing: 24) {
                            
                            Button {
                                
                            } label: {
                                Image("facebook-icon")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                            }
                            
                            Button {
                                
                            } label: {
                                Image("google-icon")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                            }
                        }
                    }
                    .padding(.vertical)
                    
                    Spacer()
                    
                    // Sign in button
                    Button {
                        authViewModel.signIn(withEmail: email, password: password)
                    } label: {
                        HStack{
                            Text("CONNEXION")
                                .foregroundStyle(.black)
                            Image(systemName: "arrow.right")
                                .foregroundStyle(.black)
                        }
                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    }
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Spacer()
                    
                    // Sign up button
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        HStack{
                            Text("Pas encore inscrit ?")
                                .font(.system(size: 14))
                            
                            Text("Créer un compte")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
