//
//  UsersModel.swift
//  Corre Atras
//
//  Created by Lucas Lacerda on 03/02/24.
//

import Foundation
import CloudKit

class User: ObservableObject {
    var recordID: CKRecord.ID?
    var username: String
    var password: String
    var email: String
    @Published var exercises: [Exercise]

    init(username: String, password: String, email: String, exercises: [Exercise]) {
        self.username = username
        self.password = password
        self.email = email
        self.exercises = exercises
    }
    
}

extension User {
    private func addExercise(description: String?, elapsedTime: TimeInterval?, photo: Data?) {
        let endTime = Date()
        let startTime = endTime.addingTimeInterval(-(elapsedTime ?? 0))
        
        let exercise = Exercise(startTime: startTime, endTime: endTime, description: description, elapsedTime: elapsedTime, photo: photo)
        exercises.append(exercise)
    }
}
