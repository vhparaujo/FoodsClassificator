//
//  FormsPage3.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import SwiftUI
import SwiftData

struct FormsPage3: View {
    @Environment(\.modelContext) private var context
    
    @Bindable private var perfilViewModel = PerfilViewModel()
    
    @State private var showingTipKit = false
    
    var body: some View {
        VStack {
                        
            QuestionTextComponent(QuestionLabel: "Qual o seu sexo biológico?")
                .padding(.top)
              
            HStack{
                ForEach(perfilViewModel.sexos, id: \.self) { sexo in
                    Button(action: {
                        perfilViewModel.model.sexoBiologico = sexo
                    }) {
                        Capsule()
                            .foregroundStyle(.verdeFundo)
                            .overlay {
                                Text(sexo)
                                    .foregroundStyle(.verdeTitle)
                                    .font(.headline)
                            }
                            .frame(height: 45)
                            .opacity(perfilViewModel.model.sexoBiologico == sexo ? 1.0 : 0.5)
                    }
                }
            }
            HStack{
                Button(action: {
                    showingTipKit.toggle()
                }) {
                    HStack {
                        Image(systemName: "questionmark.circle.fill")
                            .foregroundStyle(Color.laranjaEscuro)

                        Text("Qual Devo Escolher?")
                            .foregroundStyle(Color.laranjaEscuro)
                        
                    }.padding()
                    
                }
                .sheet(isPresented: $showingTipKit) {
                    TipKitView()
                        .presentationDetents([.fraction(0.93)])
                        .presentationDragIndicator(.visible)
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
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
        .padding()
        .onAppear{
            perfilViewModel.modelContext = context
        }
        
    }
}

#Preview {
    let modelContainer: ModelContainer = .appContainer
    return FormsPage3().modelContainer(modelContainer)
}
