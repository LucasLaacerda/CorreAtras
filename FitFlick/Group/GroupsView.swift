//
//  GroupsAndRankingView.swift
//  FitFlick
//
//  Created by Lucas Lacerda on 03/02/24.
//

import Foundation
import SwiftUI


struct GroupsView: View {
    let groups: [Group] = [
        Group(name: "Grupo A", members: [
            User(username: "Usuário 1", password: "senha1", email: "email1@example.com", exercises: [])
        ]),
        Group(name: "Grupo B", members: [
            User(username: "Usuário 2", password: "senha2", email: "email2@example.com", exercises: []),
            User(username: "Usuário 3", password: "senha3", email: "email3@example.com", exercises: [])
        ])
    ]

    var body: some View {
        NavigationView {
            List(groups, id: \.name) { group in
                NavigationLink(destination: GroupDetailView(group: group)) {
                    VStack(alignment: .leading) {
                        Text(group.name)
                            .font(.headline)

                        Text("Membros: \(group.members.count)")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        if let leader = group.leader {
                            Text("Líder: \(leader.username)")
                                .font(.subheadline)
                                .foregroundColor(.green)
                        }

                        // Adicione sua lógica para encontrar a posição do usuário no ranking aqui
                        if let userPosition = group.members.firstIndex(where: { $0.username == "Usuário 1" }) {
                            Text("Sua posição: \(userPosition + 1)°")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("Grupos e Ranking")
            .navigationBarItems(trailing:
               NavigationLink(destination: CreateGroupView()) {
                    Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundColor(.blue)
             }
           )
         }
        .navigationBarBackButtonHidden(true)
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView()
    }
}


