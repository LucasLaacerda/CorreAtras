//
//  ExerciseTimerView.swift
//  Corre Atras
//
//  Created by Lucas Lacerda on 03/02/24.
//

import Foundation
import SwiftUI
import UIKit
import AVFoundation

struct ExerciseTimerView: View {
    @State private var timer: Timer?
    @State private var elapsedTime: TimeInterval = 0
    @State private var isTimerRunning = false
    @State private var exerciseCount = 0
    @State private var showImagePicker = false
    @State private var showDescriptionAlert = false
    @State private var exerciseDescription = ""
    @State private var selectedSourceType: UIImagePickerController.SourceType?
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var image: UIImage?
    private var currentUser: User?
    
    var body: some View {
        VStack {
            Text("Tempo Total: \(formattedTime(elapsedTime))")
                .font(.title)
                .padding()

            HStack {
                Button(action: {
                        startTimer()
                }) {
                    Text("Iniciar Exercício")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    // Finalizar o exercício
                    stopTimer()

                    // Adicionar tempo ao total apenas se o exercício for concluído
                    addExerciseTime(elapsedTime)

                    // Adicionar +1 ao contador de dias
                    exerciseCount += 1
                    showDescriptionAlert = true
                }) {
                    Text("Finalizar Exercício")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .padding()
        .alert(isPresented: $showDescriptionAlert) {
                    Alert(
                        title: Text("Finalizar Exercício"),
                        message: Text("Adicione uma descrição opcional e tire uma foto para comprovar o exercício."),
                        primaryButton: .default(Text("Selecionar Foto")) {
                            selectedSourceType = .photoLibrary
                            showImagePicker = true
                            isImagePickerPresented.toggle()
                        },
                        secondaryButton: .default(Text("Tirar Foto")) {
                            selectedSourceType = .camera
                            showImagePicker = true
                        }
                        
                    )
                }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $selectedImage, isImagePickerPresented: $isImagePickerPresented, sourceType: .photoLibrary)
        }

    }
    

    private func saveExerciseDetails(_ time: TimeInterval, description: String, photo: Data?) {
        if let selectedImage = image {
                // Processar a imagem aqui (salvar no armazenamento, enviar para o servidor, etc.)
            print("Imagem do exercício processada.")
        }
            
        currentUser?.addExercise(description: description, elapsedTime: time, photo: photo)
    }

    // Função para formatar o tempo como uma string no formato "HH:mm:ss"
    private func formattedTime(_ time: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter.string(from: time) ?? "00:00:00"
    }

    // Função para iniciar o temporizador
    private func startTimer() {
        isTimerRunning = true
        elapsedTime = 0

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.elapsedTime += 1
        }
    }

    // Função para parar o temporizador
    private func stopTimer() {
        isTimerRunning = false
        timer?.invalidate()
        timer = nil
    }

    // Função para adicionar o tempo do exercício ao total
    private func addExerciseTime(_ time: TimeInterval) {
        // Adicione sua lógica aqui para salvar o tempo do exercício ao total
        // Você pode usar UserDefaults, CoreData ou outro método de armazenamento
        print("Adicionando \(formattedTime(time)) ao tempo total.")
    }
}

struct ExerciseTimerView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTimerView()
    }
}
