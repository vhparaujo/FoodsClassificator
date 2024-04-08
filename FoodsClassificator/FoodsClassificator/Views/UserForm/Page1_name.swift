//
//  Page1_name.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 07/04/24.
//
//
//  Page1_name.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 07/04/24.
//

import SwiftUI

struct Page1_name: View {
    @State var nome:String = ""
    @State var percent: CGFloat = 002

    var body: some View {
        NavigationStack {
            VStack {
//                FormProgressBar(percent: $percent)
                // Conteúdo da página aqui
                QuestionTextComponent(label: "Como gostaria de ser chamado(a)?")
                
                TextFieldRectangleComponent(placeholder: "Insira seu nome", text: $nome)
                
                Spacer()
                
                Image("form_page1")
                
                Spacer() // Empurra o conteúdo para cima e o botão para baixo
                
                // NavigationLink para a próxima página do questionário
                NavigationLink(destination: Page2_age()) {
                    NextButtonLabel(label: "Próximo")
                }
            }
            .padding()
        }
    }
}

#Preview {
    Page1_name()
}
