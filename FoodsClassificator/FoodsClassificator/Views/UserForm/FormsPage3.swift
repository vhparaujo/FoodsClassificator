//
//  FormsPage3.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import SwiftUI

struct FormsPage3: View {
    @Environment(\.modelContext) private var context

    @Bindable private var viewModel = PerfilViewModel()

    @State private var gender = 0
    let genders = ["Female", "Male"]
    
    var body: some View {
            VStack {
                FormProgressBar(percent: .constant(0.48))
                
                Group {
                    QuestionTextComponent(QuestionLabel: "Qual o seu sexo biológico?")
                }
                
                HStack{
                    ForEach(viewModel.sexos, id: \.self) { index in
                        Button(action: {
                            viewModel.model.sexoBiologico = index
                            print(viewModel.model.sexoBiologico)
                            
                        }) {
                            Capsule()
                                .foregroundStyle(.green.opacity(0.4))
                                .overlay {
                                    Text(viewModel.model.sexoBiologico)                      .tint(.black)
                                }
                                .frame(height: 50)
                                .opacity(viewModel.model.sexoBiologico == index ? 1.0 : 0.5)
                        }
                    }
                }
                
                Spacer()
                
                Image("form_page3")
                
                Spacer()
                
                // NavigationLink para a próxima página do questionário
                NavigationLink(destination: FormsPage4()) {
                    NextButtonLabel(nextButtonLabel: "Próximo")
                }
            }
            .padding()
            .onAppear{
            viewModel.modelContext = context
        }
            .environment(PerfilViewModel())
        }
    }



#Preview {
    FormsPage3()
}
