//
//  RankingView.swift
//  FitFlick
//
//  Created by Lucas Lacerda on 03/02/24.
//

import Foundation
import SwiftUI

struct RankingView: View {
    let ranking: [User] // Supondo que o ranking seja uma lista de usuários ordenados

    var body: some View {
        List(ranking, id: \.recordID) { user in
            Text("\(user.username) - Pontuação: \(user.exercises.count)")
        }
        .navigationTitle("Ranking")
    }
}
