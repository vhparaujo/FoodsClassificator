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
    @Environment(\.modelContext) private var context
    
    @Bindable private var viewModel = PerfilViewModel()
    
    var body: some View {
        VStack {
            FormProgressBar(percent: .constant(0.16))
            // Conteúdo da página aqui
            QuestionTextComponent(QuestionLabel: "Como gostaria de ser chamado(a)?")
            
            TextFieldRectangleComponent(placeholder: "Insira seu nome", text: $viewModel.model.userName)
            
            Spacer()
            
            Image("form_page1")
            
            Spacer() // Empurra o conteúdo para cima e o botão para baixo
            
            // NavigationLink para a próxima página do questionário
            NavigationLink(destination: FormsPage2()) {
                NextButtonLabel(nextButtonLabel: "Próximo")
            }
        }
        .padding()
        .onAppear{
            viewModel.modelContext = context
        }
    }
}

#Preview {
    FormsPage1()
}
