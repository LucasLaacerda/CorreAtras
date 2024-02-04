//
//  HistoryFilterOptions.swift
//  FitFlick
//
//  Created by Lucas Lacerda on 04/02/24.
//

import Foundation
import SwiftUI

struct HistoryFilterOptions: View {
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    @Binding var isModalPresented: Bool

    var body: some View {
        VStack {
            // Aqui você pode adicionar as opções de filtro
            DatePicker("De", selection: Binding<Date>(
                                get: { self.startDate ?? Date() },
                                set: { self.startDate = $0 }
                            ), displayedComponents: .date)
                            .datePickerStyle(CompactDatePickerStyle())
                            .padding()

            DatePicker("Até", selection: Binding<Date>(
                                get: { self.endDate ?? Date() },
                                set: { self.endDate = $0 }
                            ), displayedComponents: .date)
                            .datePickerStyle(CompactDatePickerStyle())
                            .padding()

            Button("Aplicar Filtro") {
                isModalPresented.toggle()
            }
            .padding()
        }
        .padding()
    }
}
