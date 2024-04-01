//
//  PerfilImageViewComponent.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftUI

struct PerfilImageViewComponent: View {
    
    @State var userPhoto: String = ""
    
    var body: some View {
        Circle()
            .overlay {
                Image(userPhoto)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle()
                    )
    
            }
            .frame(width: 100, height: 100)
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
