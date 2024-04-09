////
////  FormsPagex.swift
////  FoodsClassificator
////
////  Created by Gabriel Ribeiro Noronha on 08/04/24.
////
//
//import SwiftUI
//
//struct FormsPagex: View {
//    
//    @Bindable private var viewModel = PerfilViewModel()
//    
//    
//    var body: some View {
//        VStack {
//            FormProgressBar(percent: .constant(0.32))
//            
//            
//            QuestionTextComponent(QuestionLabel: "Quantos anos você tem?")
//            TextFieldRectangleComponent(
//                placeholder: "20",
//                text: Binding<String>(
//                    get: {
//                        String(self.viewModel.model.idade)
//                    },
//                    set: {
//                        if let value = Int($0) {
//                            self.viewModel.model.idade = value
//                        }
//                    }
//                )
//            )
//            .keyboardType(.numberPad)
//            
//            
//            
//            QuestionTextComponent(QuestionLabel: "Qual seu Peso?")
//            TextFieldRectangleComponent(placeholder: "48kg", text: $viewModel.model.peso)
//                .keyboardType(.numberPad)
//            
//            
//            
//            QuestionTextComponent(QuestionLabel: "Qual sua Altura?")
//            TextFieldRectangleComponent(placeholder: "154cm", text: $viewModel.model.altura)
//                .keyboardType(.numberPad)
//            
//            
//            Spacer()
//            
//            ZStack {
//                HStack {
//                    Image("form_page2ruler")
//                }
//                Image("form_page2Papaia")
//            }
//            
//            Spacer() // Empurra o conteúdo para cima e o botão para baixo
//            
//            // NavigationLink para a próxima página do questionário
//            NavigationLink(destination: FormsPage3()) {
//                NextButtonLabel(nextButtonLabel: "Próximo")
//            }
//        }
//    }
//}
//
//
//
//#Preview {
//    FormsPagex()
//}
