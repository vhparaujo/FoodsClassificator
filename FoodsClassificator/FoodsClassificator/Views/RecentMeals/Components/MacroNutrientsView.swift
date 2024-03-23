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
            MacroCircle(label: "Gorduras", value: macros.fats)
            MacroCircle(label: "Fibras", value: macros.fibers)
            MacroCircle(label: "Carboidratos", value: macros.carbohydrates)
            MacroCircle(label: "Proteínas", value: macros.proteins)
        }
    }
}
