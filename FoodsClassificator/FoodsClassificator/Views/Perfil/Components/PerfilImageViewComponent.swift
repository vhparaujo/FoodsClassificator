//
//  PerfilImageViewComponent.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftUI

struct PerfilImageViewComponent: View {
    
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        Circle()
            .overlay {
                Image(viewModel.userPhoto)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle()
                    )
    
            }
            .frame(width: 45, height: 45)
            .overlay {
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundStyle(.white)
            }
    }
}

#Preview {
    PerfilImageViewComponent()
}
