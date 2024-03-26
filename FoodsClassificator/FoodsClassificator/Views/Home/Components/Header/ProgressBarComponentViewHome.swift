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
        
      
            Image("mamaoHome")
                .resizable()
                .scaledToFit()
                .offset(y: -69)
    
        ZStack {

            Circle()
                .foregroundStyle(Color.laranjaFundoHome)
//                .frame(width: screenWidth * 0.5, height: 255)
            
            Circle()
                .trim(from: viewModel.initialProgressBarValue, to: viewModel.maxProgressBarValue)
                .stroke(style: StrokeStyle(lineWidth: screenWidth * 0.06, lineCap: .round))
//                .frame(width: screenWidth * 0.5, height: screenHeight * 0.2)
                .rotationEffect(.degrees(-270))
                .foregroundStyle(.white)
                    
            Circle()
                .trim(from: viewModel.initialProgressBarValue, to: viewModel.maxProgressBarValue)
                .stroke(style: StrokeStyle(lineWidth: screenWidth * 0.05, lineCap: .round))
//                .frame(width: screenWidth * 0.5, height: screenHeight * 0.2)
                .rotationEffect(.degrees(-270))
                .foregroundStyle(Color.laranjaMacros)
            
            
            Circle()
                .trim(from: viewModel.initialProgressBarValue, to: viewModel.progressBarValue)
                .stroke(style: StrokeStyle(lineWidth: screenWidth * 0.04, lineCap: .round))
//                .frame(width: screenWidth * 0.5, height: screenHeight * 0.2)
                .rotationEffect(.degrees(-270))
                .foregroundStyle(.white)
            
            VStack{
                
                Text(HomeTexts.restam)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .offset(y: 15)
                
                Text("\(viewModel.calories)")
                    .font(.title)
                    .foregroundStyle(.white)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .offset(y: 10)
                
                Text(HomeTexts.calorias)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .offset(y: 30)
            }
            
        }
        .padding()
        .background(Color.laranjaFundoHome)
        .clipShape(Circle())
        .padding()
        
    }
}

#Preview {
    ProgressBarComponentHomeView()
}


#Preview {
    HomeView()
}
