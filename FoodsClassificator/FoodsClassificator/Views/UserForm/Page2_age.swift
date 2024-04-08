//
//  Page2_age.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 07/04/24.
//

import SwiftUI

struct Page2_age: View {
    @State var idade:String = ""
    @State var peso:String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                // Conteúdo da página aqui
                QuestionTextComponent(label: "Qual sua Idade?")
                TextFieldRectangleComponent(placeholder: "Insira seu nome", text: $idade)
                    .keyboardType(.numberPad)
                
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
    Page2_age()
}
