//
//  CloudKitServices.swift
//  FitFlick
//
//  Created by Lucas Lacerda on 03/02/24.
//

import Foundation
import CloudKit

func saveUserToCloudKit(user: User, completion: @escaping (Error?) -> Void) {
    let container = CKContainer.default()
    let privateDatabase = container.privateCloudDatabase

    let userRecord = CKRecord(recordType: "User")
    userRecord["username"] = user.username
    userRecord["password"] = user.password // Certifique-se de armazenar a senha de forma segura

    privateDatabase.save(userRecord) { savedRecord, error in
        if let error = error {
            print("Erro ao salvar usuário no CloudKit: \(error.localizedDescription)")
            completion(error)
        } else {
            user.recordID = savedRecord?.recordID
            print("Usuário salvo com sucesso no CloudKit")
            completion(nil)
        }
    }
}


func authenticateUser(username: String, password: String, completion: @escaping (Bool) -> Void) {
    let container = CKContainer.default()
    let privateDatabase = container.privateCloudDatabase

    let predicate = NSPredicate(format: "username = %@ AND password = %@", username, password)
    let query = CKQuery(recordType: "User", predicate: predicate)

    privateDatabase.perform(query, inZoneWith: nil) { records, error in
        guard let userRecord = records?.first, error == nil else {
            print("Erro ao autenticar usuário: \(error?.localizedDescription ?? "Erro desconhecido")")
            completion(false)
            return
        }

        // Autenticação bem-sucedida
        UserDefaults.standard.set(userRecord.recordID.recordName, forKey: "userID")
        completion(true)
    }
}

