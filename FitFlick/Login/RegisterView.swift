//
//  RegisterView.swift
//  FitFlick
//
//  Created by Lucas Lacerda on 03/02/24.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    @State private var errorMessage: String?
    @StateObject private var viewModel = RegisterViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("Crie sua conta")
                    .font(.title)
                    .padding()

                TextField("Nome de Usuário", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("E-mail", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()

                SecureField("Senha", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                Button(action: {
                    viewModel.registerUser()
                }) {
                    Text("Registrar")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden(true)
        }
    }
    
}

extension String {
    func isValidEmail() -> Bool {
        // Lógica simples de validação de e-mail
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}

