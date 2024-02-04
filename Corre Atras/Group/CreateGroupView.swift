//
//  CreateGroupView.swift
//  Corre Atras
//
//  Created by Lucas Lacerda on 03/02/24.
//

import SwiftUI
import Contacts
import ContactsUI
import MessageUI

struct CreateGroupView: View {
    @State private var groupName = ""
    @State private var inviteCode = ""
    @State private var selectedContacts: [CNContact] = []
    @State private var isContactPickerPresented = false
    @State private var isShowingCopyAlert = false

    var body: some View {
        VStack {
            Text("Criar Novo Grupo")
                .font(.title)
                .padding()

            TextField("Nome do Grupo", text: $groupName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Adiciona a funcionalidade de selecionar contatos
            Button("Adicionar Contato") {
                isContactPickerPresented.toggle()
            }
            .padding()
            .sheet(isPresented: $isContactPickerPresented) {
                ContactPicker(isPresented: $isContactPickerPresented, selectedContacts: $selectedContacts)
            }
            
            // Adicione uma ScrollView e um VStack para listar os contatos
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(selectedContacts, id: \.identifier) { contact in
                            ContactView(contact: contact)
                    }
                }
            }


            Button(action: {
                // Gera o código de convite
                inviteCode = generateInviteCode()

                // Cria o grupo
                createGroup()

                // Adiciona os contatos selecionados à lista de membros
                selectedContacts.forEach { contact in
                    addMember(contact)
                }

                isShowingCopyAlert = true
                // Notifica os contatos selecionados
                // notifyContacts()
            }) {
                Text("Criar Grupo")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .alert(isPresented: $isShowingCopyAlert) {
                Alert(
                   title: Text("Código de Convite Gerado"),
                   message: Text("Seu código de convite é:\n\n\(inviteCode)"),
                   primaryButton: .default(Text("Copiar")) {
                                   UIPasteboard.general.string = inviteCode
                   },
                   secondaryButton: .default(Text("OK"))
                )
            }

            Spacer()
        }
        .padding()
    }
    
    struct ContactView: View {
        let contact: CNContact

        var body: some View {
            // Personalize a aparência da visualização do contato aqui
            HStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay(Circle().stroke(Color.black, lineWidth: 1))
                    .padding(.bottom, 10)
                Text("\(contact.givenName) \(contact.familyName)")
                    .font(.headline)
//                Text("Número de telefone: \(contact.phoneNumbers.first?.value.stringValue ?? "")")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
    }

    private func generateInviteCode() -> String {
        // Lógica para gerar um código único, por exemplo, uma combinação de letras e números
        return "ABC123"
    }

    private func createGroup() {
        // Lógica para criar e salvar o novo grupo, incluindo o nome e o código de convite
        // Certifique-se de ajustar conforme a estrutura de dados do seu aplicativo
        print("Criando grupo: \(groupName) - Código de Convite: \(inviteCode)")
    }

    private func addMember(_ contact: CNContact) {
        // Adiciona um membro ao grupo
        // Você pode implementar a lógica para adicionar membros ao grupo aqui
    }
}

struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroupView()
    }
}




