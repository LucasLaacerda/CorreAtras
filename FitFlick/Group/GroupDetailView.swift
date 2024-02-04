//
//  GroupDetailView.swift
//  FitFlick
//
//  Created by Lucas Lacerda on 03/02/24.
//

import Foundation
import SwiftUI

struct GroupDetailView: View {
    let group: Group

    var body: some View {
        List(group.members, id: \.username) { member in
            VStack(alignment: .leading) {
                Text(member.username)
                    .font(.headline)
                Text("Exercícios: \(member.exercises.count)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle(group.name)
    }
}
