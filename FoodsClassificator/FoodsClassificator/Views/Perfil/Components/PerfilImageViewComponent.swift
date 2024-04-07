//
//  PerfilImageViewComponent.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 06/04/24.
//

import SwiftUI

struct PerfilImageViewComponent: View {
    
    @Binding var userPhoto: Data
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 2)
            .foregroundStyle(.verdeTitle)
            .overlay {
                if let uiImage = UIImage(data: userPhoto) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(.circle)
                }
            }
    }
}
