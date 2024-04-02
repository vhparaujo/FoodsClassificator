//
//  HeaderView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 21/03/24.
//

import SwiftUI

struct HeaderView: View {
    
    @Environment(HomeViewModel.self) var viewModel: HomeViewModel
    
    var body: some View {
        
        VStack {
            
            HStack {
                UserNameComponentHomeView()
                Spacer()
                UserPhotoAndStreakComponentHomeView()
            }.padding(.horizontal)
            
            HStack {
                ZStack {
                    HStack{
                        VStack {
                            MacrosComponentHomeView(macroType: HomeTexts.proteinas, backgroundColor: Color.amareloFibras)
                                .padding(.vertical)
                            
                            MacrosComponentHomeView(macroType: HomeTexts.gorduras, backgroundColor: Color.rosaGorduras)
                                .padding(.vertical)
                        }
                        
                        Spacer()
                        
                        VStack {
                            MacrosComponentHomeView(macroType: HomeTexts.carboidratos, backgroundColor: Color.rosaProteinas)
                                .padding(.vertical)
                            
                            MacrosComponentHomeView(macroType: HomeTexts.fibras, backgroundColor: Color.verdeCarboidratos)
                                .padding(.vertical)
                        }
                    }
                    
                    ProgressBarComponentHomeView()
                        .offset(y: 50)
                        .padding(.horizontal)
                }
            }
            .padding(.bottom)
            .padding(.horizontal)
            
        }.background(Color.laranjaFundoHome)

    }
}

#Preview {
    var viewModel = HomeViewModel()
    return HeaderView()
        .environment(viewModel)
}
