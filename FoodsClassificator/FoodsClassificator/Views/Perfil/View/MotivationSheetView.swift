//
//  MotivationSheetView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftUI

struct MotivationSheetView: View {
    
    @State private var viewModel = PerfilViewModel()
    
    var body: some View {
        
        ScrollView {
            
            ModalTitles(title: "Ofensiva")
            
            StreakComponentView(dias: viewModel.streak)
            
            ModalTitles(title: "Desafios")
            
            ForEach(0..<4) {_ in
                DropDownComponentView(alimento: viewModel.alimento, dias: viewModel.dias)
            }
            
            ModalTitles(title: "Conquistas")
                .padding(.top)
            
            DropDownComponentView()
            
        }.padding(.vertical)
        
    }
}

#Preview {
    MotivationSheetView()
}
