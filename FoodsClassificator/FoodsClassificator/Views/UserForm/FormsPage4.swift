//
//  FormsPage4.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import SwiftUI

struct FormsPage4: View {
    @Environment(\.modelContext) private var context
    
    @Bindable private var viewModel = PerfilViewModel()
    
    @State private var activity = 0
    let activityLevels = ["Sedentário", "Leve", "Moderado", "Intenso", "Muito Intenso"]
    
    var body: some View {
        VStack {
//            ScrollView {
                FormProgressBar(percent: .constant(0.64))
                
                QuestionTextComponent(QuestionLabel: "Qual é o seu principal objetivo?")
                
                VStack{
                    ForEach(viewModel.objetivos, id: \.self) { objetivo in
                        Button(action: {
                            viewModel.model.objetivo = objetivo
                            print(viewModel.model.objetivo)
                        }) {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(.green.opacity(0.4))
                                .overlay {
                                    Text(objetivo)
                                        .tint(.black)
                                }
                                .frame(height: 40)
                                .opacity(viewModel.model.objetivo == objetivo ? 1.0 : 0.5)
                        }
                    }
                }.padding(.bottom)
                
                
                
                QuestionTextComponent(QuestionLabel: "Quantas vezes na semana você pratica exercício físico?")
                VStack(spacing: 10){
                    ForEach(0..<viewModel.intensidades.count, id: \.self) { index in
                        Button(action: {
                            viewModel.selectedIntensityIndex = index
                            viewModel.model.intensidadeDoExercicio = viewModel.intensidades[index]

                            print(viewModel.model.intensidadeDoExercicio)

                        }) {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(.green.opacity(0.4))
                                .overlay {
                                    Text(viewModel.intensidades[index])
                                        .foregroundStyle(.black)
                                }
                                .frame(height: 40)
                                .opacity(viewModel.model.intensidadeDoExercicio == viewModel.intensidades[index] ? 1.0 : 0.5)
                        }
                    }
                }
                
                
                Spacer()
                
                // NavigationLink para a próxima página do questionário
//            }
            NavigationLink(destination: FormsPage5()) {
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
    FormsPage4()
}
