//
//  PerfilView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftUI

struct PerfilView: View {
    
    @State private var viewModel = PerfilViewModel()
    @State private var showMotivationSheet: Bool = false
    
    var body: some View {
        
        VStack {
            
            PerfilImageViewComponent(userPhoto: viewModel.userPhoto)
            UserNameComponentPerfilView(userName: viewModel.userName)
            
            List {
                Section {
                    ListPerfilComponentView(label: PerfilTexts.idade, data: viewModel.idade)
                    ListPerfilComponentView(label: PerfilTexts.peso, data: viewModel.peso)
                    ListPerfilComponentView(label: PerfilTexts.altura, data: viewModel.altura)
                    ListPerfilComponentView(label: PerfilTexts.genero, data: viewModel.genero)
                }
                
                Section {
                    ListPerfilComponentView(label: PerfilTexts.objetivo, data: viewModel.objetivo)
                    ListPerfilComponentView(label: PerfilTexts.frequencia, data: viewModel.frequenciaExercicio)
                }
                
                Section {
                    ListPerfilComponentView(label: PerfilTexts.cafeDaManha, data: viewModel.genero)
                    ListPerfilComponentView(label: PerfilTexts.almoco, data: viewModel.genero)
                    ListPerfilComponentView(label: PerfilTexts.jantar, data: viewModel.genero)
                }
            }.background(Color.laranjaFundoHome)
            // permite colocar um background color na list
                .scrollContentBackground(.hidden)
        }.background(Color.laranjaFundoHome)
        
            .sheet(isPresented: $showMotivationSheet) {
                MotivationSheetView()
                    .presentationDetents([.fraction(0.1), .fraction(0.86)])
                    .interactiveDismissDisabled()
                    .presentationBackgroundInteraction(.enabled)
            }
        
            .onAppear {
                showMotivationSheet = true
            }
        
    }
}

#Preview {
    PerfilView()
}
