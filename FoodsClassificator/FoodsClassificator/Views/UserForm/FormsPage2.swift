//
//  FormsPage2.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 07/04/24.
//
import SwiftUI
import SwiftData

struct FormsPage2: View {
    @Environment(\.modelContext) private var context
    @Bindable private var perfilViewModel = PerfilViewModel()
    
    var body: some View {
        VStack {
            FormProgressBar(percent: .constant(0.32))
            
            QuestionTextComponent(QuestionLabel: "Quantos anos você tem?")
                .padding(.top)
            
            TextFieldRectangleComponent(placeholder: "Digite sua idade", text: $perfilViewModel.idadeAsString, textLimit: 3)
                .keyboardType(.numberPad)
            
            QuestionTextComponent(QuestionLabel: "Qual seu peso?")
            
            TextFieldRectangleComponent(placeholder: "kg", text: $perfilViewModel.pesoAsString, textLimit: 4)
                .keyboardType(.decimalPad)
            
            QuestionTextComponent(QuestionLabel: "Qual sua altura?")
            
            TextFieldRectangleComponent(placeholder: "cm", text: $perfilViewModel.alturaAsString, textLimit: 3)
                .keyboardType(.numberPad)
            
            Spacer()
            
            Image("form_page2")
                .resizable()
                .scaledToFit()
                .padding()
            
            Spacer() // Empurra o conteúdo para cima e o botão para baixo
            
            // NavigationLink para a próxima página do questionário
            NavigationLink(destination: FormsPage3()) {
                NextButtonLabel(nextButtonLabel: "Próximo")
            }
            
        }
        
        .padding()
        
        .onAppear {
            perfilViewModel.modelContext = context
        }
        
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
    }
}

#Preview {
    let modelContainer: ModelContainer = .appContainer
    return FormsPage2().modelContainer(modelContainer)
}
