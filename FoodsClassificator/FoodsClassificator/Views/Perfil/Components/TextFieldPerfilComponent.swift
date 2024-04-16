//
//  TextFieldPerfilComponent.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 16/04/24.
//

import SwiftUI
import Combine

struct TextFieldPerfilComponent: View {
    var placeholder: String
    @Binding var text: String  // Modificado para usar Binding<String>
    @State var textLimit = 3 //Your limit
    @State var keyBoardType: UIKeyboardType = .numberPad
    
    var body: some View {
        
        TextField(placeholder, text: $text) // Aqui já estamos usando Binding
            .keyboardType(keyBoardType)
            .onReceive(Just(text)) { _ in limitText(textLimit)
            }
        
    }
    
    func limitText(_ upper: Int) {
        if text.count > upper {
            text = String(text.prefix(upper))
        }
    }
    
}

#Preview {
    TextFieldPerfilComponent(placeholder: "", text: .constant(""))
}
