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
    
    @State private var showingTipKit = false

    
    var body: some View {
        VStack {
            FormProgressBar(percent: .constant(0.48))
            
            QuestionTextComponent(QuestionLabel: "Qual o seu sexo biológico?")
            
            
        
            
            HStack{
                ForEach(viewModel.sexos, id: \.self) { sexo in
                    Button(action: {
                        viewModel.model.sexoBiologico = sexo
                        print(viewModel.model.sexoBiologico)
                        
                    }) {
                        Capsule()
                            .foregroundStyle(.green.opacity(0.4))
                            .overlay {
                                Text(sexo)
                                    .foregroundStyle(.black)
                            }
                            .frame(height: 50)
                            .opacity(viewModel.model.sexoBiologico == sexo ? 1.0 : 0.5)
                    }
                }
            }
            HStack{
                Button(action: {
                    showingTipKit.toggle()
                }) {
                    HStack {
                        Image(systemName: "questionmark.circle.fill")
                            .foregroundStyle(Color.laranjaBrilhante)

                        Text("Qual Devo Escolher?")
                            .foregroundStyle(Color.laranjaBrilhante)

                    }
                    
                }
                .sheet(isPresented: $showingTipKit) {
                    TipKitView()
                }
                Spacer()
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
    }
}



#Preview {
    FormsPage3()
}
