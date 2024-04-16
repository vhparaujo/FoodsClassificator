//
//  TextFieldRectangleComponent.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import SwiftUI
import Combine

struct TextFieldRectangleComponent: View {
    
    var placeholder: String
    @Binding var text: String  // Modificado para usar Binding<String>
    @State var textLimit = 12 //Your limit
    
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .stroke(lineWidth: 1.0)
            .opacity(0.3)
            .frame(height: UIScreen.main.bounds.height * 0.04)
            .overlay {
                TextField(placeholder, text: $text) // Aqui já estamos usando Binding
                    .padding(.horizontal)
                
                    .onReceive(Just(text)) { _ in limitText(textLimit)
                    }
            }
        
    }
    
    func limitText(_ upper: Int) {
        if text.count > upper {
            text = String(text.prefix(upper))
        }
    }
    
}


#Preview {
    TextFieldRectangleComponent(placeholder: "Digite algo...", text: .constant("Texto inicial"))
        .padding() // Adiciona um pouco de espaço ao redor para a pré-visualização
        .previewLayout(.sizeThatFits) // Ajusta o layout da pré-visualização ao tamanho do conteúdo
}
