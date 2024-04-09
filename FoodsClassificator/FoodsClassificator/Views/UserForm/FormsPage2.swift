//
//  FormsPage2.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 07/04/24.
//
import SwiftUI

struct FormsPage2: View {
    @Environment(\.modelContext) private var context
    @Bindable private var viewModel = PerfilViewModel()
    
    var body: some View {
        VStack {
            FormProgressBar(percent: .constant(0.32))
            
            
            QuestionTextComponent(QuestionLabel: "Quantos anos você tem?")
            TextFieldRectangleComponent(placeholder: "20", text: $viewModel.idadeAsString)
                .keyboardType(.numberPad)
                .onTapGesture {
                    print(viewModel.model.idade)
                }
            
            
            
            QuestionTextComponent(QuestionLabel: "Qual seu Peso?")
            TextFieldRectangleComponent(placeholder: "48kg", text: $viewModel.pesoAsString)
                .keyboardType(.numberPad)
                .onTapGesture {
                    print(viewModel.model.peso)
                }
            
            
            QuestionTextComponent(QuestionLabel: "Qual sua Altura?")
            TextFieldRectangleComponent(placeholder: "154cm", text: $viewModel.alturaAsString)
                .keyboardType(.numberPad)
            
            
            Spacer()
            
            ZStack {
                HStack {
                    Image("form_page2ruler")
                }
                Image("form_page2Papaia")
            }
            
            Spacer() // Empurra o conteúdo para cima e o botão para baixo
            
            // NavigationLink para a próxima página do questionário
            NavigationLink(destination: FormsPage3()) {
                NextButtonLabel(nextButtonLabel: "Próximo")
            }
        }
        .onAppear{
            viewModel.modelContext = context
        }
        .environment(PerfilViewModel())
    }
}



#Preview {
    FormsPage2()
}
