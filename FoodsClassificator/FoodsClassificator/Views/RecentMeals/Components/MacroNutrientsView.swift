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
            MacroCircle(label: "Gorduras", value: macros.fats, color: .blue)
            MacroCircle(label: "Fibras", value: macros.fibers, color: .purple)
            MacroCircle(label: "Carboidratos", value: macros.carbohydrates, color: .yellow)
            MacroCircle(label: "Proteínas", value: macros.proteins, color: .pink)
        }
    }
}
