//
//  HeaderView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 21/03/24.
//

import SwiftUI

struct HeaderView: View {
    
    @Environment(HomeViewModel.self) var viewModel
    
    var background = BackgroundShapeHeaderHomeView()
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        
        VStack {
            
            HStack {
                UserNameComponentHomeView()
                Spacer()
                UserPhotoAndStreakComponentHomeView()
            }.padding()
            
            ZStack {
                
                HStack {
                    
                    VStack {
                        
                        MacrosComponentHomeView(macroType: HomeTexts.carboidratos, backgroundColor: Color.amareloCarboidratos)
                            .padding(.vertical)
                        
                        MacrosComponentHomeView(macroType: HomeTexts.gorduras, backgroundColor: Color.rosaGorduras)
                            .padding(.vertical)
                    }
                
                    Spacer()
                    
                    VStack {
                        
                        MacrosComponentHomeView(macroType: HomeTexts.proteinas, backgroundColor: Color.rosaProteinas)
                            .padding(.vertical)
                        
                        MacrosComponentHomeView(macroType: HomeTexts.fibras, backgroundColor: Color.amareloFibras)
                            .padding(.vertical)
                    }
                    
                }
                .padding(.bottom)
            .padding(.horizontal)
                
                VStack {
                    ProgressBarComponentHomeView()
                        .offset(y:40)
                        .padding(.horizontal)
                }.frame(width: screenWidth * 0.5)
                
            }
            
        }
        .background(
            GeometryReader { geometry in
                background.path(in: CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height * 1.05))
                    .foregroundStyle(.verdeFundo)
            }
            .ignoresSafeArea(edges: .all)
        )
    }
}

#Preview {
    var viewModel = HomeViewModel()
    return HeaderView()
        .environment(viewModel)
}
