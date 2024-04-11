//
//  FormsPage5.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import SwiftUI

struct FormsPage5: View {
    @Environment(\.modelContext) private var context
    
    @Bindable private var viewModel = PerfilViewModel()
    @State private var refeicao = 0
    let refeicoes:[String] = ["Café da manhã", "Lanche da manhã", "Almoço", "Lanche da tarde", "Jantar"]
    
    
    var body: some View {
        VStack {
            Group {
                FormProgressBar(percent: .constant(0.80))
            }
            
            
            QuestionTextComponent(QuestionLabel: "Quais refeições você faz por dia?")
            
            VStack {
                
                ForEach(viewModel.model.refeicoes, id: \.self) { refeicao in
                    
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
                    
                }.onMove(perform: move)
                .onDelete(perform: delete)
               
                TextField("Nome da refeição", text: $viewModel.textFieldName)
                    .onSubmit {
                        viewModel.model.refeicoes.append(viewModel.textFieldName)
                        viewModel.textFieldName = ""
                    }
            }
 
            Spacer()
        
            // NavigationLink para a próxima página do questionário
            NavigationLink(destination: FormsPage6()) {
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
    
    func delete(at offsets: IndexSet) {
        viewModel.model.refeicoes.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        viewModel.model.refeicoes.move(fromOffsets: source, toOffset: destination)
    }
}


#Preview {
    FormsPage5()
}
