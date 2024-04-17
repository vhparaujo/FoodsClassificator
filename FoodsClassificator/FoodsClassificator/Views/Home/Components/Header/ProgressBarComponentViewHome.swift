//
//  ProgressBarComponentViewHome.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 21/03/24.
//

import SwiftUI

struct ProgressBarComponentHomeView: View {
    
    @Environment(\.modelContext) var context
    
    @State var perfilViewModel = PerfilViewModel()
    
    var homeViewModel: HomeViewModel
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
    
        HStack {
            ZStack {
                
                Image("mamaoHome")
                    .resizable()
                    .scaledToFit()
                    .offset(y: -60)

                Circle()
                    .foregroundStyle(Color.verdeFundo)
                
                Circle()
                    .trim(from: homeViewModel.initialProgressBarValue, to: homeViewModel.maxProgressBarValue)
                    .stroke(style: StrokeStyle(lineWidth: 23, lineCap: .round))
    //                .frame(width: screenWidth * 0.4, height: screenHeight * 0.2)
                    .rotationEffect(.degrees(-270))
                    .foregroundStyle(.verdeTitle)
                        
                Circle()
                    .trim(from: homeViewModel.initialProgressBarValue, to: homeViewModel.maxProgressBarValue)
                    .stroke(style: StrokeStyle(lineWidth: 19, lineCap: .round))
    //                .frame(width: screenWidth * 0.4, height: screenHeight * 0.2)
                    .rotationEffect(.degrees(-270))
                    .foregroundStyle(Color.white)
                    .opacity(0.8)
                
                Circle()
                    .trim(from: homeViewModel.initialProgressBarValue, to: homeViewModel.progressBarValue)
                    .stroke(style: StrokeStyle(lineWidth: 14, lineCap: .round))
    //                .frame(width: screenWidth * 0.4, height: screenHeight * 0.2)
                    .rotationEffect(.degrees(-270))
                    .foregroundStyle(.verdeTitle)
                
                VStack{
                    
                    Text(HomeTexts.restam)
                        .font(.title2)
                        .foregroundStyle(.verdeTitle)
                        .bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .offset(y: 15)
                    
                    Text("\(perfilViewModel.model.totalCalories)")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.verdeTitle)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .offset(y: 10)
                    
                    Text(HomeTexts.calorias)
                        .font(.headline)
                        .foregroundStyle(.verdeTitle)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .offset(y: 30)
                }
                
            }
        }
        .padding(.horizontal)
        .onAppear{
            perfilViewModel.modelContext = context
            perfilViewModel.caloriesPerDay()
        }

    }
}

//#Preview {
//    var viewModel = HomeViewModel()
//    return ProgressBarComponentHomeView(viewModel: viewModel)
//        .environment(viewModel)
//}

#Preview {
    HomeView()
}
