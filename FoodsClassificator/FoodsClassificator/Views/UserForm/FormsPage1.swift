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
import SwiftData

struct FormsPage1: View {
    @Environment(\.modelContext) private var context
    
    @Bindable private var perfilViewModel = PerfilViewModel()
    
    var body: some View {
        VStack {
            FormProgressBar(progress: perfilViewModel.progress)

            // Conteúdo da página aqui
            QuestionTextComponent(QuestionLabel: "Como gostaria de ser chamado(a)?")
                .padding(.top)
            
            TextFieldRectangleComponent(placeholder: "Insira seu nome", text: $perfilViewModel.model.userName)
                
            
            Spacer()
            
            Image("form_page1")
            
            Spacer() // Empurra o conteúdo para cima e o botão para baixo
            
            // NavigationLink para a próxima página do questionário
            NavigationLink(destination: FormsPage2()) {
                NextButtonLabel(nextButtonLabel: "Próximo")
            }
            
        }
        .padding()
        .onAppear(perform: {
            perfilViewModel.modelContext = context
        })
        
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    let modelContainer: ModelContainer = .appContainer
    return FormsPage1().modelContainer(modelContainer)
}
