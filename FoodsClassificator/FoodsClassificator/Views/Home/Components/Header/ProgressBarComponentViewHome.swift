//
//  ProgressBarComponentViewHome.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 21/03/24.
//

import SwiftUI

struct ProgressBarComponentHomeView: View {
    
    @State private var viewModel = HomeViewModel()
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .frame(width: screenWidth * 0.5, height: 200)
                .foregroundStyle(Color.laranjaFundoHome)
            
            Image("mamaoHome")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth * 0.3, height: 180)
                .offset(y: -64)
            
            Circle()
                .frame(width: screenWidth * 0.3, height: 155)
                .foregroundStyle(Color.laranjaFundoHome)
            
            Circle()
                .trim(from: viewModel.initialProgressBarValue, to: viewModel.maxProgressBarValue)
                .stroke(style: StrokeStyle(lineWidth: 23, lineCap: .round))
                .frame(width: screenWidth * 0.5, height: 136)
                .rotationEffect(.degrees(-270))
                .foregroundStyle(.white)
                    
            Circle()
                .trim(from: viewModel.initialProgressBarValue, to: viewModel.maxProgressBarValue)
                .stroke(style: StrokeStyle(lineWidth: 19, lineCap: .round))
                .frame(width: screenWidth * 0.5, height: 136)
                .rotationEffect(.degrees(-270))
                .foregroundStyle(Color.laranjaMacros)
            
            Circle()
                .trim(from: viewModel.initialProgressBarValue, to: viewModel.progressBarValue)
                .stroke(style: StrokeStyle(lineWidth: 14, lineCap: .round))
                .frame(width: screenWidth * 0.5, height: 136)
                .rotationEffect(.degrees(-270))
                .foregroundStyle(.white)
            
            VStack{
                
                Text(HomeTexts.restam)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
                    .offset(y: 15)
                
                Text("\(viewModel.calories)")
                    .font(.title)
                    .foregroundStyle(.white)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
                    .offset(y: 10)
                
                Text(HomeTexts.calorias)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
                    .offset(y: 30)
            }
            
        }
        
    }
}

#Preview {
    ProgressBarComponentHomeView()
}


