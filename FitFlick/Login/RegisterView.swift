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
                    registerUser()
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

    func registerUser() {
        // Validar os campos antes de prosseguir
        guard !username.isEmpty else {
            errorMessage = "Por favor, insira um nome de usuário."
            return
        }

        guard !email.isEmpty && email.isValidEmail() else {
            errorMessage = "Por favor, insira um e-mail válido."
            return
        }

        guard !password.isEmpty else {
            errorMessage = "Por favor, insira uma senha."
            return
        }

        // Implementar a lógica de autenticação usando iCloud ou outras soluções
        // Certificar-se de obter username, password e email do usuário

        let user = User(username: username, password: password, email: email, exercises: []) // Exercícios inicialmente vazios
        saveUserToCloudKit(user: user) { error in
            if let error = error {
                // Lidar com o erro (exibir mensagem, retornar falso, etc.)
                print("Erro ao salvar usuário no CloudKit: \(error.localizedDescription)")
                errorMessage = "Erro ao registrar. Tente novamente."
            } else {
                // Registro e salvamento bem-sucedidos
                print("Usuário registrado com sucesso.")
                // Realizar o login após o registro bem-sucedido
                authenticateUser(username: username, password: password) { success in
                    if success {
                        print("Login bem-sucedido após registro.")
                        // Você pode agora navegar para a próxima tela ou realizar outras ações necessárias após o login
                    } else {
                        print("Falha no login após registro.")
                        // Lidar com a falha no login, se necessário
                    }
                }
                errorMessage = nil // Limpar mensagem de erro se tudo estiver bem
            }
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

