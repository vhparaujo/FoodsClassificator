//
//  Header.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 23/03/24.
//

import SwiftUI

struct HeaderView: View {
    var meal: Meal
    var title: String
    @Binding var isExpanded: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(title)
                    .font(.largeTitle)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(.white)
                    .bold()
                    .padding()
                
                if isExpanded {
                    SemiCircularProgressBar(value: Double(meal.totalCalories / 2000))
                } else {
                    ProgressBar(value: Double(meal.totalCalories / 2000))
                        .padding(.horizontal, geometry.size.width * 0.3)
                }
                
                Text("\(meal.totalCalories) calorias")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(.white)
                    .padding(.top, isExpanded ? -geometry.size.height * 0.06 : -geometry.size.height * 0.07)
                
                if isExpanded {
                    MacroNutrientsView(macros: meal.macros)
                        .padding(.top, -geometry.size.height * 0.02)
                }
                
                Spacer()
            }
            .animation(.easeInOut, value: isExpanded)
            .background(Color.myOrange)
            .frame(height: isExpanded ? geometry.size.height * 0.37 : geometry.size.height * 0.2)
            .padding(.top, -geometry.size.height * 0.02)
        }
    }
}
