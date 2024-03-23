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
        VStack {
            Text(title)
                .font(isExpanded ? .title : .title2)
                .frame(maxWidth: .infinity, alignment: .center)
            
            ProgressBar(value: Double(meal.totalCalories / 2000)) // Asume um valor máximo de calorias
            
            if isExpanded {
                MacroNutrientsView(macros: meal.macros)
            }
        }
        .animation(.easeInOut, value: isExpanded)
        .padding()
    }
}
