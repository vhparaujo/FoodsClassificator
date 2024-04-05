//
//  MotivationSheetView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftUI

struct MotivationView: View {
    
    @Bindable private var viewModel = PerfilViewModel()
    @Environment(\.modelContext) private var context
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                PerfilImageViewComponent(userPhoto: $viewModel.model.userPhoto)
                    .frame(width: 80, height: 80)
                
                NavigationLink {
                    PerfilView()
                } label: {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundStyle(.verdeTitle)
                        Text("Dados Pessoais")
                            .foregroundStyle(.verdeTitle)
                            .font(.callout)
                    }
                }

            }.frame(maxWidth: .infinity)
            
            ScrollView {
                ModalTitles(title: "Ofensiva")
                    .padding(.top)
                
                StreakComponentView(dias: viewModel.model.streak)
                
                ModalTitles(title: "Desafios")
                    .padding(.top)
                
//                ForEach(0..<4) {_ in
//                    DropDownComponentView(alimento: viewModel.model.alimentos, dias: viewModel.dias)
//                }

                ModalTitles(title: "Conquistas")
                    .padding(.top)
                
                DropDownComponentView()
            }
            .background(.white)
            
        }
        .background(Color.verdeFundo)
        
        .onAppear(perform: {
            viewModel.modelContext = context
        })
        
    }
}

#Preview {
    MotivationView()
}
