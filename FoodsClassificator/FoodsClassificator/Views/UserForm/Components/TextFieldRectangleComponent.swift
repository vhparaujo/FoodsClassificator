//
//  TextFieldRectangleComponent.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import SwiftUI

struct TextFieldRectangleComponent: View {
    @Environment(PerfilViewModel.self) var perfilViewModel

    var placeholder: String
    @Binding var text: String  // Modificado para usar Binding<String>
    
    var body: some View {
        Rectangle()
            .stroke(lineWidth: 1.0)
            .opacity(0.3)
            .frame(height: UIScreen.main.bounds.height * 0.04)
            .overlay {
                TextField(placeholder, text: $text) // Aqui já estamos usando Binding
                    .padding(.horizontal)
            }
    }
}


#Preview {
    TextFieldRectangleComponent(placeholder: "Digite algo...", text: .constant("Texto inicial"))
        .padding() // Adiciona um pouco de espaço ao redor para a pré-visualização
        .previewLayout(.sizeThatFits) // Ajusta o layout da pré-visualização ao tamanho do conteúdo
}
