//
//  RegistrationView.swift
//  UberClone
//
//  Created by Lorenzo Menino on 31/08/2024.
//

import SwiftUI

struct RegistrationView: View {
    
    @State var fullname = ""
    @State var email = ""
    @State var password = ""
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .imageScale(.medium)
                        .padding()
                }
                Text("Créer un compte")
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                   // .multilineTextAlignment(.leading)
                    .frame(width: 250)
                
                Spacer()
                
                VStack {
                    VStack(spacing: 56) {
                        CustomInputField(text: $fullname,
                                         title: "Nom et prénom",
                                         placeholder: "Entrez votre nom")
                        
                        CustomInputField(text: $email,
                                         title: "Adresse email",
                                         placeholder: "nom@exemple.com")
                        
                        CustomInputField(text: $password,
                                         title: "Mot de passe",
                                         placeholder: "Entrez votre mot de passe",
                                         isSecureField: true)
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Button {
                        viewModel.registerUser(withEmail: email,
                                               password: password,
                                               fullname: fullname)
                    } label: {
                        HStack{
                            Text("CRÉER UN COMPTE")
                                .foregroundStyle(.black)
                            Image(systemName: "arrow.right")
                                .foregroundStyle(.black)
                        }
                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    }
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Spacer()
                }
            }
             .foregroundStyle(.white)
        }
    }
}

#Preview {
    RegistrationView()
}
