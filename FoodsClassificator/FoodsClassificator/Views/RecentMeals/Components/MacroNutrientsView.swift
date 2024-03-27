//
//  MacroNutrientsView.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 23/03/24.
//

import SwiftUI

struct MacroNutrientsView: View {
    var macros: Macronutrients
    
    var body: some View {
        HStack {
            MacroCircle(label: HomeTexts.gorduras, value: macros.fats, color: .blue)
            MacroCircle(label: HomeTexts.fibras, value: macros.fibers, color: .purple)
            MacroCircle(label: HomeTexts.carboidratos, value: macros.carbohydrates, color: .yellow)
            MacroCircle(label: HomeTexts.proteinas, value: macros.proteins, color: .pink)
        }
    }
}
