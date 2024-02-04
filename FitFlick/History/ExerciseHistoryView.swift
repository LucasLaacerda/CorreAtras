//
//  ExerciseHistoryView.swift
//  FitFlick
//
//  Created by Lucas Lacerda on 03/02/24.
//

import SwiftUI

struct ExerciseHistoryView: View {
    @ObservedObject var user: User
    @State private var isFilterModalPresented = false
    @State private var startDate: Date?
    @State private var endDate: Date?

    var filteredExercises: [Exercise] {
        guard let startDate = startDate, let endDate = endDate else {
            return user.exercises
        }

        return user.exercises.filter {
            $0.startTime >= startDate && $0.startTime <= endDate
        }
    }

    var body: some View {
        NavigationView {
            List(filteredExercises) { exercise in
                ExerciseHistoryRow(exercise: exercise)
            }
            .navigationBarTitle("Histórico")
            .navigationBarItems(trailing:
                Button(action: {
                    isFilterModalPresented.toggle()
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding()
                }
                .sheet(isPresented: $isFilterModalPresented) {
                    HistoryFilterOptions(startDate: $startDate, endDate: $endDate, isModalPresented: $isFilterModalPresented)
                }
            )
        }
    }
}
