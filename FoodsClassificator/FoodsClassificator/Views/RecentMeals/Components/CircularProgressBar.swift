//
//  CircularProgressBar.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 02/04/24.
//

import SwiftUI

struct CircularProgressBar: View {
    var meal: Meal
    var progressBarValue: Double = 0.7
    var maxProgressBarValue: Double = 0.88
    var initialProgressBarValue: Double = 0.12
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: screenWidth * 0.38)
                .foregroundStyle(Color.verdeFundo)
            
            Circle()
                .trim(from: initialProgressBarValue, to: maxProgressBarValue)
                .stroke(style: StrokeStyle(lineWidth: screenWidth * 0.05, lineCap: .round))
                .frame(width: screenWidth * 0.28)
                .rotationEffect(.degrees(-270))
                .foregroundStyle(.white)
                    
            Circle()
                .trim(from: initialProgressBarValue, to: maxProgressBarValue)
                .stroke(style: StrokeStyle(lineWidth: screenWidth * 0.04, lineCap: .round))
                .frame(width: screenWidth * 0.28)
                .rotationEffect(.degrees(-270))
                .foregroundStyle(Color.laranjaMacros)
            
            Circle()
                .trim(from: initialProgressBarValue, to: progressBarValue)
                .stroke(style: StrokeStyle(lineWidth: screenWidth * 0.025, lineCap: .round))
                .frame(width: screenWidth * 0.28)
                .rotationEffect(.degrees(-270))
                .foregroundStyle(.white)
            
            VStack {
                Text("\(meal.totalCalories)")
                    .font(.title)
                    .foregroundStyle(.white)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
                    .offset(y: 10)
                
                Text("Calorias")
                    .font(.callout)
                    .foregroundStyle(.white)
//                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
                    .offset(y: screenHeight * 0.045)
            }
            
        }
        
    }
}

//#Preview {
//    CircularProgressBar()
//}



