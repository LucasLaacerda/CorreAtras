//
//  ContactPicker.swift
//  FitFlick
//
//  Created by Lucas Lacerda on 03/02/24.
//

import Foundation
import SwiftUI
import ContactsUI

struct ContactPicker: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var selectedContacts: [CNContact]

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CNContactPickerViewController()
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(isPresented: $isPresented, selectedContacts: $selectedContacts)
    }

    class Coordinator: NSObject, CNContactPickerDelegate {
        @Binding var isPresented: Bool
        @Binding var selectedContacts: [CNContact]

        init(isPresented: Binding<Bool>, selectedContacts: Binding<[CNContact]>) {
            _isPresented = isPresented
            _selectedContacts = selectedContacts
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            // Adiciona o contato selecionado à lista de membros
            selectedContacts.append(contact)

            // Feche o picker após a seleção
            isPresented = false
        }

        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            // Lidar com o cancelamento do picker
            // Feche o picker quando o usuário cancelar
            isPresented = false
        }
    }
}

