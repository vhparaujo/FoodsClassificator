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
    
    @State var selectedItems: Set<String> = [] // Conjunto para armazenar os itens selecionados
    
    @State private var isEditMode = false // Definindo o estado de edição como verdadeiro

    var body: some View {
        
        VStack {
            
            FormProgressBar(progress: perfilViewModel.progress)

            QuestionTextComponent(QuestionLabel: "Quais refeições você faz por dia?")
                .padding(.top)
                .padding(.horizontal)
            
            List(selection: $selectedItems) {
                Section {
                    ForEach(perfilViewModel.model.refeicoes.indices, id: \.self) { index in
                        
                        HStack {
                            TextField("Nome da refeição", text:  $perfilViewModel.model.refeicoes[index])
                                .foregroundStyle(.verdeTitle)
                                .font(.headline)
                            Spacer()
                        }
                        .padding(10)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: perfilViewModel.model.refeicoes.count > 1 ? delete : nil)
                    .onMove(perform: move)
                }
                .listRowBackground(Color.verdeFundo)
            }
            .listRowSpacing(10)
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
    
            Spacer()
            
            Button(action: {
                perfilViewModel.model.refeicoes.append(perfilViewModel.textFieldName)
            }, label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Nova Refeição")
                    Spacer()
                }
                .foregroundStyle(.laranjaEscuro)
                .font(.title3)
                .padding()
            })
            
            // NavigationLink para a próxima página do questionário
            NavigationLink(destination: FormsPage6(perfilViewModel: perfilViewModel)) {
                NextButtonLabel(nextButtonLabel: "Próximo")
            }
            .padding(.horizontal)
            
        }
        
        .toolbar(content: {
            EditButton()
                .foregroundStyle(.laranjaEscuro)
        })
        
        .onAppear {
            perfilViewModel.modelContext = context
            perfilViewModel.progress = 0.8

        }
        
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        perfilViewModel.model.refeicoes.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        perfilViewModel.model.refeicoes.move(fromOffsets: source, toOffset: destination)
    }
    
}

#Preview {
    NavigationStack{
        let modelContainer: ModelContainer = .appContainer
        return FormsPage5().modelContainer(modelContainer)
    }
}

