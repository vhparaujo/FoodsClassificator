//
//  ProgressBarComponentViewHome.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 21/03/24.
//

import SwiftUI

struct ProgressBarComponentHomeView: View {
    
    @Environment(HomeViewModel.self) var viewModel: HomeViewModel
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
    
        ZStack {
            
            Image("mamaoHome")
                .resizable()
                .scaledToFit()
                .offset(y: -69)

            Circle()
                .foregroundStyle(Color.laranjaFundoHome)
//                .clipShape(Circle())
//                .frame(width: screenWidth * 0.3, height: 255)
            
            Circle()
                .trim(from: viewModel.initialProgressBarValue, to: viewModel.maxProgressBarValue)
                .stroke(style: StrokeStyle(lineWidth: 23, lineCap: .round))
//                .frame(width: screenWidth * 0.4, height: screenHeight * 0.2)
                .rotationEffect(.degrees(-270))
                .foregroundStyle(.white)
                    
            Circle()
                .trim(from: viewModel.initialProgressBarValue, to: viewModel.maxProgressBarValue)
                .stroke(style: StrokeStyle(lineWidth: 19, lineCap: .round))
//                .frame(width: screenWidth * 0.4, height: screenHeight * 0.2)
                .rotationEffect(.degrees(-270))
                .foregroundStyle(Color.laranjaMacros)
            
            
            Circle()
                .trim(from: viewModel.initialProgressBarValue, to: viewModel.progressBarValue)
                .stroke(style: StrokeStyle(lineWidth: 14, lineCap: .round))
//                .frame(width: screenWidth * 0.4, height: screenHeight * 0.2)
                .rotationEffect(.degrees(-270))
                .foregroundStyle(.white)
            
            VStack{
                
                Text(HomeTexts.restam)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .offset(y: 15)
                
                Text("\(viewModel.calories)")
                    .font(.title)
                    .foregroundStyle(.white)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .offset(y: 10)
                
                Text(HomeTexts.calorias)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .offset(y: 30)
            }
            
        }
//        .padding()
//        .background(Color.laranjaFundoHome)
//        .clipShape(Circle())
//        .padding()
        
    }
}

#Preview {
    var viewModel = HomeViewModel()
    return ProgressBarComponentHomeView()
        .environment(viewModel)
}

#Preview {
    HomeView()
}
