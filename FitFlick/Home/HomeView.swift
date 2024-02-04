//
//  HomevIEW.swift
//  FitFlick
//
//  Created by Lucas Lacerda on 03/02/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
        // Exemplo de dados fictícios para exercícios
        let exercisesMock: [Exercise] = [
            Exercise(startTime: Date(), endTime: Date(), description: "Caminhada matinal", elapsedTime: 600, photo: nil),
            Exercise(startTime: Date(), endTime: Date(), description: "Treino de cardio", elapsedTime: 1200, photo: nil),
            Exercise(startTime: Date(), endTime: Date(), description: "Exercício de peso", elapsedTime: 900, photo: nil),
            Exercise(startTime: Date(), endTime: Date(), description: "Yoga relaxante", elapsedTime: 800, photo: nil),
            Exercise(startTime: Date(), endTime: Date(), description: "Corrida no parque", elapsedTime: 1500, photo: nil)
        ]
        var userExample = User(username: "Usuário 14", password: "senha1", email: "email1@example.com", exercises: exercisesMock)
        
        TabView {
            ExerciseTimerView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            Text("Feed")
                .tabItem {
                    Label("Feed", systemImage: "square.stack")
                }
            
            GroupsView()
                .tabItem {
                    Label("Grupos", systemImage: "person.3.fill")
                }
            
            ExerciseHistoryView(user: userExample)
                .tabItem {
                    Label("Histórico", systemImage: "clock")
                }
            
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }.navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
