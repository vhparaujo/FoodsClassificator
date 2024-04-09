//
//  FormsPage6.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import SwiftUI

struct FormsPage6: View {
    @Environment(\.modelContext) private var context
    
    @Bindable private var viewModel = PerfilViewModel()
    
    @State private var haveNutritionist = false
    @State var meta:String = ""
    var body: some View {
        VStack {
            FormProgressBar(percent: .constant(0.91))
            
            
            QuestionTextComponent(QuestionLabel: "Você possui uma meta de calorias prescrita por nutricionista?")
            
            HStack {
                Button(action: {
                    haveNutritionist = true
                    print("Tem Nutricionista")
                }, label: {
                    Capsule()
                        .foregroundStyle(.green.opacity(0.4))
                        .overlay {
                            Text("Sim")
                                .tint(.black)
                        }
                        .frame(height: 50)
                })
                .opacity(haveNutritionist ? 1.0 : 0.5)
                
                Button(action: {
                    haveNutritionist = false
                    print("nao tem Nutricionista")
                }, label: {
                    Capsule()
                        .foregroundStyle(.green.opacity(0.4))
                        .overlay {
                            Text("Nao")
                                .tint(.black)
                        }
                        .frame(height: 50)
                })
                .opacity(haveNutritionist ? 0.5 : 1.0)
            }
            
            
            if haveNutritionist {
                QuestionTextComponent(QuestionLabel: "Qual é a sua meta?")
                TextFieldRectangleComponent(placeholder: "1800cal", text: $meta)
                    .keyboardType(.numberPad)
            }
            
            Spacer()
            
            Image("form_page6")
            
            Spacer()
            
            // NavigationLink para a próxima página do questionário
            NavigationLink(destination: HomeView()) {
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
    FormsPage6()
}
