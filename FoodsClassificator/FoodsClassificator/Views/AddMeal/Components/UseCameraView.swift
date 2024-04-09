//
//  UseCameraView.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 05/04/24.
//

import SwiftUI

struct UseCameraView: View {
    var onScanMeal: () -> Void

    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        VStack {
            Image("AddMealImage")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth * 0.38, height: screenHeight * 0.15)
                .padding()
            
            Text("Adicione sua primeira refeição")
                .foregroundColor(Color.laranjaMacros)
                .font(.title3)
                .padding()
            
            Spacer()
            
            Button(action: onScanMeal) {
                HStack {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .bold()
                        .font(.title3)
                    
                    Text("Escanear")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .frame(width: screenWidth * 0.4, height: screenHeight * 0.05)
            .background(Color.laranjaFundoHome)
            .cornerRadius(28)
            .padding(.bottom, screenHeight * 0.04) 
        }
    }
}
