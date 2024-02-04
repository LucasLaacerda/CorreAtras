//
//  LoginView.swift
//  Corre Atras
//
//  Created by Lucas Lacerda on 03/02/24.
//

import Foundation
import SwiftUI
import CloudKit

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    Text("Corre Atrás!")
                        .font(.title)
                        .padding()

                    TextField("Nome de Usuário", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    SecureField("Senha", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    NavigationLink("Não tem uma conta? Registre-se aqui", destination: RegisterView())
                        .foregroundColor(.blue)
                    NavigationLink("Login", destination: HomeView())
                        .foregroundColor(.blue)

                    Button(action: {
                        
                        authenticateUser(username: username, password: password) { isAuthenticated in
                            if isAuthenticated {
                                // Navegar para a tela inicial ou HomeView após a autenticação bem-sucedida
                                // Certifique-se de configurar sua HomeView
                                NavigationLink(destination: HomeView()) {
                                    EmptyView()
                                }
                            } else {
                                // Exibir uma mensagem de erro ou tratar de outra forma
                                print("Falha na autenticação.")
                            }
                        }
                    }) {
                        Text("Login")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Spacer()
                }
                .padding()
                .frame(height: geometry.size.height/2) // Ajuste de altura para centralizar
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}



