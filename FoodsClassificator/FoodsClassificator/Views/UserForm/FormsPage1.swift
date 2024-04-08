//
//  FormsPage1.swift
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

struct FormsPage1: View {
    @State var nome:String = ""
    @State var percent: CGFloat = 0.20

    var body: some View {
        NavigationStack {
            VStack {
                FormProgressBar(percent: .constant(0.16))
                // Conteúdo da página aqui
                QuestionTextComponent(QuestionLabel: "Como gostaria de ser chamado(a)?")
                
                TextFieldRectangleComponent(placeholder: "Insira seu nome", text: $nome)
                
                Spacer()
                
                Image("form_page1")
                
                Spacer() // Empurra o conteúdo para cima e o botão para baixo
                
                // NavigationLink para a próxima página do questionário
                NavigationLink(destination: FormsPage2()) {
                    NextButtonLabel(nextButtonLabel: "Próximo")
                }
            }
            .padding()
        }
    }
}

#Preview {
    FormsPage1()
}
