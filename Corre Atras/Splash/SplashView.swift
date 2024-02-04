//
//  SplashView.swift
//  Corre Atras
//
//  Created by Lucas Lacerda on 03/02/24.
//

import Foundation
import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            Image(systemName: "waveform.path.ecg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .padding()

            Text("Seu App de Exercícios")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)

            Text("Prepare-se para uma vida mais saudável!")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()

            Spacer()
        }
        .padding()
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
