//
//  Image+Extension.swift
//  Corre Atras
//
//  Created by Lucas Lacerda on 03/02/24.
//

import Foundation
import SwiftUI

extension Image {
    init(data: Data) {
        guard let uiImage = UIImage(data: data) else {
            self = Image(systemName: "photo") // Use um ícone padrão se a conversão falhar
            return
        }

        self = Image(uiImage: uiImage)
    }
}
