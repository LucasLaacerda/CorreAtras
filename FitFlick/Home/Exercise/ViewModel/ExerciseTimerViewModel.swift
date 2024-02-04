//
//  ExerciseTimerViewModel.swift
//  FitFlick
//
//  Created by Lucas Lacerda on 04/02/24.
//

import Foundation
import Combine
import SwiftUI

class ExerciseTimerViewModel: ObservableObject {
    @Published var elapsedTime: TimeInterval = 0
    @Published var isTimerRunning = false
    @Published var exerciseCount = 0
    @Published var timer: Timer?
    @Published var exerciseDescription = ""
    @Published var selectedSourceType: UIImagePickerController.SourceType?
    @Published var image: UIImage?
    private var currentUser: User?

    init() {
        // Configurar assinantes, se necessário
    }

    func startTimer() {
        guard !isTimerRunning else { return }

        isTimerRunning = true
        elapsedTime = 0

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.elapsedTime += 1
        }
    }

    func stopTimer() {
        guard isTimerRunning else { return }

        isTimerRunning = false
        timer?.invalidate()
        timer = nil
    }

    func addExerciseTime(_ time: TimeInterval) {
        // Adicione sua lógica aqui para salvar o tempo do exercício ao total
        // Pode ser armazenamento local, CloudKit, etc.
        print("Adicionando \(formattedTime(time)) ao tempo total.")
        // Você pode adicionar mais lógica, como enviar para o servidor, etc.
    }

    func formattedTime(_ time: TimeInterval) -> String {
            let hours = Int(time) / 3600
            let minutes = Int(time) % 3600 / 60
            let seconds = Int(time) % 60

            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    private func saveExerciseDetails(_ time: TimeInterval, description: String, photo: Data?) {
        if let selectedImage = image {
                // Processar a imagem aqui (salvar no armazenamento, enviar para o servidor, etc.)
            print("Imagem do exercício processada.")
        }
            
        currentUser?.addExercise(description: description, elapsedTime: time, photo: photo)
    }
}
