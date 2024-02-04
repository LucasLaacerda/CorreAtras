//
//  ExerciseHistoryView.swift
//  Corre Atras
//
//  Created by Lucas Lacerda on 03/02/24.
//

import Foundation
import SwiftUI

struct ExerciseHistoryView: View {
    @ObservedObject var user: User

    var body: some View {
        NavigationView {
            List {
                ForEach(user.exercises) { exercise in
                    ExerciseHistoryRow(exercise: exercise)
                }
            }
        }
    }
}
