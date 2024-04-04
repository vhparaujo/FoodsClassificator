//
//  MotivationSheetView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftUI

struct MotivationView: View {
    
    @State private var viewModel = PerfilViewModel()
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                PerfilImageViewComponent(userPhoto: viewModel.userPhoto)
                
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
                
                StreakComponentView(dias: viewModel.streak)
                
                ModalTitles(title: "Desafios")
                    .padding(.top)
                
                ForEach(0..<4) {_ in
                    DropDownComponentView(alimento: viewModel.alimento, dias: viewModel.dias)
                }
                
                ModalTitles(title: "Conquistas")
                    .padding(.top)
                
                DropDownComponentView()
            }
            .background(.white)
            
        }
        .background(Color.verdeFundo)
        
    }
}

#Preview {
    MotivationView()
}
