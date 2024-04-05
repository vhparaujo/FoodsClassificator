//
//  HeaderView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 21/03/24.
//

import SwiftUI

struct HeaderView: View {
    
    @Environment(HomeViewModel.self) var viewModel
    
    var myIcon = MyIcon()
    
    var body: some View {
        
        VStack {
            
            HStack {
                UserNameComponentHomeView()
                Spacer()
                UserPhotoAndStreakComponentHomeView()
            }.padding()
            
            
            HStack {
                
                VStack {
                    MacrosComponentHomeView(macroType: HomeTexts.proteinas, backgroundColor: Color.amareloFibras)
                        .padding(.vertical)
                    
                    MacrosComponentHomeView(macroType: HomeTexts.gorduras, backgroundColor: Color.rosaGorduras)
                        .padding(.vertical)
                }
                
                ProgressBarComponentHomeView()
                    .offset(x: 5, y: 40)
                    .padding(.horizontal)
                
                
                
                VStack {
                    MacrosComponentHomeView(macroType: HomeTexts.carboidratos, backgroundColor: Color.rosaProteinas)
                        .padding(.vertical)
                    
                    MacrosComponentHomeView(macroType: HomeTexts.fibras, backgroundColor: Color.verdeCarboidratos)
                        .padding(.vertical)
                }
                
            }
//            .padding(.bottom)
            .padding(.horizontal)
            
        }.background(
            GeometryReader { geometry in
                myIcon.path(in: CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height * 1.17))
                    .foregroundStyle(.laranjaFundoHome)
            }
        )
    }
}

#Preview {
    var viewModel = HomeViewModel()
    return HeaderView()
        .environment(viewModel)
}

#Preview {
    HomeView()
}
