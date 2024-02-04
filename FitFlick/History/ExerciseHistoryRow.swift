//
//  ExerciseHistoryRow.swift
//  FitFlick
//
//  Created by Lucas Lacerda on 03/02/24.
//

import SwiftUI

struct ExerciseHistoryRow: View {
    var exercise: Exercise

    var body: some View {
        VStack(alignment: .leading) {
            Text("Data: \(formattedDate(exercise.startTime))")
            Text("Descrição: \(exercise.description ?? "Sem descrição")")
            Text("Tempo Gasto: \(formattedTime(exercise.elapsedTime ?? 0))")
            if let imageData = exercise.photo {
                // Use a extensão de Image para criar a imagem a partir dos dados binários
                Image(data: imageData)
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(height: 100) // Ajuste a altura conforme necessário
                      .cornerRadius(8)
                      .padding(.top, 8)
            }
        }
        .padding()
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    private func formattedTime(_ time: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter.string(from: time) ?? "00:00:00"
    }
}
