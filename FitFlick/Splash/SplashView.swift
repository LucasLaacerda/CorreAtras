//
//  SplashView.swift
//  FitFlick
//
//  Created by Lucas Lacerda on 03/02/24.
//

import Foundation
import SwiftUI

struct SplashView: View {
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    Image(systemName: "chart.bar.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .padding()
                    
                    Text("FitFlick")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    
                    Text("Você saudavel e no topo!")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding()
                    
                    Spacer()
                }
                .padding()
                .frame(height: geometry.size.height/2)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .transition(.scale)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
