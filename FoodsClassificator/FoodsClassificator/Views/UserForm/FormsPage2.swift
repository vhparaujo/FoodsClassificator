//
//  FormsPage2.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 07/04/24.
//

import SwiftUI

struct FormsPage2: View {
    @State var idadeString:String = ""
    @State var pesoString:String = ""
    var body: some View {
        NavigationStack {
            VStack {
                FormProgressBar(percent: .constant(0.32))

                Group {
                    QuestionTextComponent(QuestionLabel: "Quantos anos você tem?")
                TextFieldRectangleComponent(placeholder: "20", text: $idadeString)
                    .keyboardType(.numberPad)
                }
                
                Group {
                    QuestionTextComponent(QuestionLabel: "Qual seu Peso?")
                TextFieldRectangleComponent(placeholder: "48kg", text: $idadeString)
                    .keyboardType(.numberPad)
                }
                
                Group {
                    QuestionTextComponent(QuestionLabel: "Qual sua Altura?")
                TextFieldRectangleComponent(placeholder: "154cm", text: $idadeString)
                    .keyboardType(.numberPad)
                }
               
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
            .padding()
        }
    }
}


#Preview {
    FormsPage2()
}
