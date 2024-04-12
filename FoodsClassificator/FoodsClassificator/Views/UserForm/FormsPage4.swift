//
//  FormsPage4.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import SwiftUI
import SwiftData

struct FormsPage4: View {
    @Environment(\.modelContext) private var context
    
    @Bindable private var viewModel = PerfilViewModel()
    
    @State private var activity = 0
    let activityLevels = ["Sedentário", "Leve", "Moderado", "Intenso", "Muito Intenso"]
    
    var body: some View {
        VStack {
            FormProgressBar(percent: .constant(0.64))
            
            QuestionTextComponent(QuestionLabel: "Qual é o seu principal objetivo?")
                .padding(.top)
            
            VStack {
                ForEach(viewModel.objetivos, id: \.self) { objetivo in
                    
                    Button {
                        viewModel.model.objetivo = objetivo
                    } label: {
                        HStack {
                            
                            Text(objetivo)
                                .tint(.verdeTitle)
                                .font(.headline)
                            
                            Spacer()
                            
                        }.padding()
                            .background(.verdeFundo)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .opacity(viewModel.model.objetivo == objetivo ? 1.0 : 0.3)
                        
                    }
                    
                }
            }.padding(.bottom)
            
            QuestionTextComponent(QuestionLabel: "Qual a intensidade de atividade física?")
                
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
            
            NavigationLink(destination: FormsPage5()) {
                NextButtonLabel(nextButtonLabel: "Próximo")
            }
        }
        .padding()
        .onAppear{
            viewModel.modelContext = context
        }
        
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
    }
}

#Preview {
    let modelContainer: ModelContainer = .appContainer
    return FormsPage4().modelContainer(modelContainer)
}
