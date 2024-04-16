//
//  FormsPage6.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import SwiftUI
import SwiftData

struct FormsPage6: View {
    @Environment(\.modelContext) private var context
        
    @Bindable var perfilViewModel = PerfilViewModel()

    @State var meta:String = ""
    var body: some View {
        VStack {
            
            FormProgressBar(percent: .constant(0.91))
            
            QuestionTextComponent(QuestionLabel: "Você possui uma meta de calorias prescrita por nutricionista?")
                .padding(.top)
                .font(.title3)
            
            HStack {
                Button(action: {
                    perfilViewModel.model.temNutricionista = false
                }, label: {
                    Capsule()
                        .foregroundStyle(.verdeFundo)
                        .overlay {
                            Text("Não")
                                .tint(.black)
                        }
                        .frame(height: 50)
                })
                .opacity(perfilViewModel.model.temNutricionista ? 0.5 : 1.0)
                
                Button(action: {
                    perfilViewModel.model.temNutricionista = true
                }, label: {
                    Capsule()
                        .foregroundStyle(.verdeFundo)
                        .overlay {
                            Text("Sim")
                                .tint(.black)
                        }
                        .frame(height: 50)
                })
                .opacity(perfilViewModel.model.temNutricionista ? 1.0 : 0.5)
            }
            
            if perfilViewModel.model.temNutricionista  {
                QuestionTextComponent(QuestionLabel: "Qual é a sua meta?")
                TextFieldRectangleComponent(placeholder: "1800cal", text: $meta, textLimit: 4)
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
            perfilViewModel.modelContext = context
        }
        
    }
}

#Preview {
    let modelContainer: ModelContainer = .appContainer
    return FormsPage6().modelContainer(modelContainer)
}
