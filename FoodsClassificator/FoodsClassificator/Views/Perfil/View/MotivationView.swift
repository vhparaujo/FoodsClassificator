//
//  MotivationSheetView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftUI
import SwiftData

struct MotivationView: View {
    
    @Bindable var perfilViewModel: PerfilViewModel
    @Environment(\.modelContext) private var context
    
    var body: some View {
        
        VStack {
            
            NavigationLink {
                PerfilView(perfilViewModel: perfilViewModel)
            } label: {
                VStack {
                    
                    PerfilImageViewComponent(perfilViewModel: perfilViewModel)
                        .frame(width: 80, height: 80)
                    
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundStyle(.verdeTitle)
                        Text("Dados Pessoais")
                            .foregroundStyle(.verdeTitle)
                            .font(.callout)
                    }
                }.frame(maxWidth: .infinity)
            }
            
            ScrollView {
                ModalTitles(title: "Ofensiva")
                    .padding(.top)
                
                StreakComponentView(dias: $perfilViewModel.model.streak)
                
                ModalTitles(title: "Desafios")
                    .padding(.top)
                
                ForEach(0..<4) {_ in
                    DropDownComponentView(alimento: "chocolate", streak: perfilViewModel.model.streak)
                }

                ModalTitles(title: "Conquistas")
                    .padding(.top)
                
                DropDownComponentView()
            }
            .background(.white)
            
        }
        .background(Color.verdeFundo)
        
        .onAppear(perform: {
            perfilViewModel.modelContext = context
        })
        
    }
}

#Preview {
    let modelContainer: ModelContainer = .appContainer
    return MotivationView(perfilViewModel: PerfilViewModel()).modelContainer(modelContainer)
}
