//
//  FormsPage5.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import SwiftUI
import SwiftData

struct FormsPage5: View {
    @Environment(\.modelContext) private var context
    
    @Bindable private var perfilViewModel = PerfilViewModel()
    
    @State private var refeicao = 0
    
    let refeicoes:[String] = ["Café da manhã", "Lanche da manhã", "Almoço", "Lanche da tarde", "Jantar"]
    
    var body: some View {
        VStack {
            
            
            QuestionTextComponent(QuestionLabel: "Quais refeições você faz por dia?")
                .padding(.top)
            
            VStack {
                
                ForEach(perfilViewModel.model.refeicoes, id: \.self) { refeicao in
                    
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(.green.opacity(0.4))
                        .overlay {
                            HStack {
                                Text(refeicao)
                                    .tint(.black)
                                Spacer()
                                Image(systemName: "list.bullet")
                                    .foregroundStyle(Color.black)
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 50)
                        .opacity(refeicao == refeicao ? 1.0 : 0.5)
                    
                }
                
                TextField("Nome da refeição", text: $perfilViewModel.textFieldName)
                    .onSubmit {
                        perfilViewModel.model.refeicoes.append(perfilViewModel.textFieldName)
                        perfilViewModel.textFieldName = ""
                    }
            }
            
            Spacer()
            
            // NavigationLink para a próxima página do questionário
            NavigationLink(destination: FormsPage6(perfilViewModel: perfilViewModel)) {
                NextButtonLabel(nextButtonLabel: "Próximo")
            }
            
        }
        .padding()
        .onAppear{
            perfilViewModel.modelContext = context
        }
        
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
//    func delete(at offsets: IndexSet) {
//        perfilViewModel.model.refeicoes.remove(atOffsets: offsets)
//    }
//    
//    func move(from source: IndexSet, to destination: Int) {
//        perfilViewModel.model.refeicoes.move(fromOffsets: source, toOffset: destination)
//    }
    
}

#Preview {
    let modelContainer: ModelContainer = .appContainer
    return FormsPage5().modelContainer(modelContainer)
}
