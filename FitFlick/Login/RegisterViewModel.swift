//
//  RegisterViewModel.swift
//  FitFlick
//
//  Created by Lucas Lacerda on 04/02/24.
//

import Foundation
import SwiftUI
import MessageUI

class RegisterViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var email = ""
    @Published var errorMessage: String?

    
    func sendWelcomeEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.setSubject("Bem-vindo ao FitFlick!")
            mail.setToRecipients([self.email])
            
            // Adicione aqui o corpo do e-mail, se necessário
            mail.setMessageBody("Obrigado por se cadastrar no FitFlick. Esperamos que aproveite a experiência!", isHTML: false)

            // Apresente o MFMailComposeViewController na tela
            UIApplication.shared.windows.first?.rootViewController?.present(mail, animated: true)
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
                self.errorMessage = "Erro ao registrar. Tente novamente."
            } else {
                // Registro e salvamento bem-sucedidos
                print("Usuário registrado com sucesso.")
                self.sendWelcomeEmail()
                // Realizar o login após o registro bem-sucedido
                authenticateUser(username: self.username, password: self.password) { success in
                    if success {
                        print("Login bem-sucedido após registro.")
                        // Você pode agora navegar para a próxima tela ou realizar outras ações necessárias após o login
                    } else {
                        print("Falha no login após registro.")
                        // Lidar com a falha no login, se necessário
                    }
                }
                self.errorMessage = nil // Limpar mensagem de erro se tudo estiver bem
            }
        }
    }}
