//
//  TextFieldRectangleComponent.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import SwiftUI

struct TextFieldRectangleComponent: View {
    var placeholder: String
    @Binding var text: String
//    @Environment(FormViewModel.self) private var formViewModel

    var body: some View {
//        @Bindable var formViewModel = formViewModel
        Rectangle()
            .stroke(lineWidth: 1.0)
            .opacity(0.3)
            .frame(height: UIScreen.main.bounds.height * 0.04)
            .overlay {
                TextField(placeholder, text: $text)
                    .padding(.horizontal)
            }
    }
}

#Preview {
    TextFieldRectangleComponent(placeholder: "Digite algo...", text: .constant("Texto inicial"))
        .padding() // Adiciona um pouco de espaço ao redor para a pré-visualização
        .previewLayout(.sizeThatFits) // Ajusta o layout da pré-visualização ao tamanho do conteúdo
}
