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
    
    @Bindable private var perfilViewModel = PerfilViewModel()
    
    @State private var activity = 0
    let activityLevels = ["Sedentário", "Leve", "Moderado", "Intenso", "Muito Intenso"]
    
    var body: some View {
        VStack {
            FormProgressBar(percent: .constant(0.64))
            
//                .padding(.top)
//                .padding(.horizontal)
            
            Form {
//                Section(content: {
                        
                        Picker("",selection: $perfilViewModel.model.objetivo) {
                            ForEach(perfilViewModel.objetivos, id: \.self) {
                                Text($0).tag($0)
//                                    .onTapGesture {
//                                        print(objetivo)
//                                    }
                            }
                        }
                        .pickerStyle(.inline)
                        
                    
//                    .padding(1)
//                }, header: {
//                    QuestionTextComponent(QuestionLabel: "Qual é o seu principal objetivo?")
//                        .font(.headline)
//                        .foregroundStyle(.black)
//                })
                .listRowBackground(Color.verdeFundo)
                
            }
//            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            
            List {
                Section(content: {
                        
                        Picker(selection: $perfilViewModel.model.intensidadeDoExercicio) {
                            ForEach(perfilViewModel.intensidades, id: \.self) { objetivo in
                                Text(objetivo).tag(objetivo)
                            }
                        } label: {
                            Text("Intensidade Exercício")
                                .font(.headline)
                                .foregroundStyle(.verdeTitle)
                        }.pickerStyle(.inline)
      
                    .padding(1)
                }, header: {
                    QuestionTextComponent(QuestionLabel: "Qual a intensidade de atividade física?")
                        .font(.headline)
                        .foregroundStyle(.black)
                }) {
                    
                   
                }
                .listRowBackground(Color.verdeFundo)
                
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            
            // NavigationLink para a próxima página do questionário
            NavigationLink(destination: FormsPage5()) {
                NextButtonLabel(nextButtonLabel: "Próximo")
            }
            .padding()
            
        }
 
        .onAppear{
            perfilViewModel.modelContext = context
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
