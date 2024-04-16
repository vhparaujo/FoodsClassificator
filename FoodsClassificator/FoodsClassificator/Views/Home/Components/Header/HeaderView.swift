//
//  HeaderView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 21/03/24.
//

import SwiftUI

struct HeaderView: View {
    var homeViewModel: HomeViewModel
    var background = BackgroundShapeHeaderHomeView()
    var perfilViewModel: PerfilViewModel
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        
        VStack {
            
            HStack {
                UserNameComponentHomeView(viewModel: homeViewModel)
                
                Spacer()
                UserPhotoAndStreakComponentHomeView(viewModel: homeViewModel, perfilViewModel: perfilViewModel)
            }.padding()
            
            ZStack {
                
                HStack {
                    
                    VStack {
                        
                        MacrosComponentHomeView(macroType: HomeTexts.carboidratos, backgroundColor: Color.amareloCarboidratos, macro: homeViewModel.totalMeals?.macros.carbohydrates ?? 0)
                            .padding(.vertical)
                        let _ = print("CARBOIDRATOS: \(homeViewModel.totalMeals?.macros.carbohydrates)")
                        MacrosComponentHomeView(macroType: HomeTexts.gorduras, backgroundColor: Color.rosaGorduras, macro: homeViewModel.totalMeals?.macros.fats ?? 0)
                            .padding(.vertical)
                    }
                    
                    Spacer()
                    
                    VStack {
                        
                        MacrosComponentHomeView(macroType: HomeTexts.proteinas, backgroundColor: Color.rosaProteinas, macro: homeViewModel.totalMeals?.macros.proteins ?? 0)
                            .padding(.vertical)
                        
                        MacrosComponentHomeView(macroType: HomeTexts.fibras, backgroundColor: Color.amareloFibras, macro: homeViewModel.totalMeals?.macros.fibers ?? 0)
                            .padding(.vertical)
                    }
                    
                }
                .padding(.bottom)
                .padding(.horizontal)
                
                VStack {
                    ProgressBarComponentHomeView(homeViewModel: homeViewModel)
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

//#Preview {
//    var viewModel = HomeViewModel()
//    return HeaderView()
//        .environment(viewModel)
//}
