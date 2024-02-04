//
//  ExerciseModel.swift
//  Corre Atras
//
//  Created by Lucas Lacerda on 03/02/24.
//

import Foundation

struct Exercise: Identifiable {
    var id = UUID()
    var startTime: Date
    var endTime: Date?
    var description: String?  // Adicionado para descrição opcional do exercício
    var elapsedTime: TimeInterval?
    var photo: Data?
}
