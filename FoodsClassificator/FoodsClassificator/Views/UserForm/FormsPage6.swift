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
    
    @Bindable private var viewModel = PerfilViewModel()
    @Bindable private var homeViewModel = HomeViewModel()
    @Bindable private var perfilViewModel = PerfilViewModel()
    
    @State var meta:String = ""
    var body: some View {
        VStack {
            
            FormProgressBar(percent: .constant(0.91))
            
            QuestionTextComponent(QuestionLabel: "Você possui uma meta de calorias prescrita por nutricionista?")
                .padding(.top)
            
            HStack {
                Button(action: {
                    viewModel.model.temNutricionista = false
                    print("nao tem Nutricionista")
                }, label: {
                    Capsule()
                        .foregroundStyle(.green.opacity(0.4))
                        .overlay {
                            Text("Não")
                                .tint(.black)
                        }
                        .frame(height: 50)
                })
                .opacity(viewModel.model.temNutricionista ? 0.5 : 1.0)
                
                Button(action: {
                    viewModel.model.temNutricionista = true
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
                .opacity(viewModel.model.temNutricionista ? 1.0 : 0.5)
            }
            
            
            if viewModel.model.temNutricionista  {
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
        
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}


#Preview {
    let modelContainer: ModelContainer = .appContainer
    return FormsPage6().modelContainer(modelContainer)
}
