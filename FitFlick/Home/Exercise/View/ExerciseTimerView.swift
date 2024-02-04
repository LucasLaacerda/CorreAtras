//
//  ExerciseTimerView.swift
//  FitFlick
//
//  Created by Lucas Lacerda on 03/02/24.
//

import Foundation
import SwiftUI
import UIKit
import AVFoundation

struct ExerciseTimerView: View {
    @StateObject private var viewModel = ExerciseTimerViewModel()
    @State private var showImagePicker = false
    @State private var showDescriptionAlert = false
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage?

    var body: some View {
        VStack {
            Text("Tempo Total: \(viewModel.formattedTime(viewModel.elapsedTime))")
                .font(.title)
                .padding()

            HStack {
                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    viewModel.startTimer()
                }) {
                    Text("Iniciar Exercício")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    // Finalizar o exercício
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    viewModel.stopTimer()

                    // Adicionar tempo ao total apenas se o exercício for concluído
                    viewModel.addExerciseTime(viewModel.elapsedTime)

                    // Adicionar +1 ao contador de dias
                    viewModel.exerciseCount += 1
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
                            viewModel.selectedSourceType = .photoLibrary
                            isImagePickerPresented.toggle()
                        },
                        secondaryButton: .default(Text("Tirar Foto")) {
                            viewModel.selectedSourceType = .camera
                            isImagePickerPresented = true
                        }
                        
                    )
                }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $selectedImage, isImagePickerPresented: $isImagePickerPresented, sourceType: .photoLibrary)
        }

    }
    
}

struct ExerciseTimerView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTimerView()
    }
}
