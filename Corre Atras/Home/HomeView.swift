//
//  HomevIEW.swift
//  Corre Atras
//
//  Created by Lucas Lacerda on 03/02/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
        var userExample = User(username: "Usuário 14", password: "senha1", email: "email1@example.com", exercises: [])
        TabView {
            ExerciseTimerView()
                .tabItem {
                    Label("Exercício", systemImage: "timer")
                }
            
            GroupsView()
                .tabItem {
                    Label("Grupos", systemImage: "person.3.fill")
                }
            
            ExerciseHistoryView(user: userExample)
                .tabItem {
                    Label("Histórico", systemImage: "clock")
                }
        }.navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
