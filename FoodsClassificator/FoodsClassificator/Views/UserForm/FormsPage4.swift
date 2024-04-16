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
            
            QuestionTextComponent(QuestionLabel: "Qual o seu principal objetivo?")
                .font(.title2)
                .padding(.top)
                .padding(.horizontal)
            
            HStack {
                
                Text("Objetivo")
                    .font(.headline)
                    .foregroundStyle(.verdeTitle)
                
                Spacer()
                
                Picker("",selection: $perfilViewModel.model.objetivo) {
                    ForEach(perfilViewModel.objetivos, id: \.self) {
                        Text($0).tag($0)
                    }
                }
                .pickerStyle(.menu)
                
            }.padding()
                .background(.verdeFundo)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.horizontal)
            
            QuestionTextComponent(QuestionLabel: "Qual sua intensidade de atividade física?")
                .font(.title2)
                .padding(.top)
                .padding(.horizontal)
      
            HStack {
                
                Text("Intensidade")
                    .font(.headline)
                    .foregroundStyle(.verdeTitle)
                
                Spacer()
                
                Picker(selection: $perfilViewModel.model.intensidadeDoExercicio) {
                    ForEach(perfilViewModel.intensidades, id: \.self) { objetivo in
                        Text(objetivo).tag(objetivo)
                    }
                } label: {
                    Text("Intensidade")
                        .font(.headline)
                        .foregroundStyle(.verdeTitle)
                }.pickerStyle(.menu)
                
            }.padding()
                .background(.verdeFundo)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.horizontal)
            
            Spacer()
            
            Image("form_page4")
                .resizable()
                .scaledToFit()
                .padding()
            
            Spacer()
            
            // NavigationLink para a próxima página do questionário
            NavigationLink(destination: FormsPage5()) {
                NextButtonLabel(nextButtonLabel: "Próximo")
            }
            .padding()
            
        }
 
        .onAppear{
            perfilViewModel.modelContext = context
        }
        
    }
}

#Preview {
    let modelContainer: ModelContainer = .appContainer
    return FormsPage4().modelContainer(modelContainer)
}
