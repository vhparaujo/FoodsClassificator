//
//  MacroNutrientsView.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 23/03/24.
//

import SwiftUI

struct MacroNutrientsView: View {
    var macros: Macronutrients
    var screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            // HStack para os textos
            HStack {
                
                Text("Gorduras")
                    .offset(x: -screenWidth * 0.08)
                Text("Fibras")
                    .offset(x: screenWidth * 0.005)
                Text("Carboidratos")
                    .offset(x: screenWidth * 0.06)
                Text("Proteínas")
                    .offset(x: screenWidth * 0.08)
            }
            .foregroundColor(.white)

            // HStack para os círculos
            HStack(spacing: screenWidth * 0.1) { // Ajuste o espaçamento conforme necessário
                MacroCircle(value: macros.fats, color: Color.rosaGorduras)
                MacroCircle(value: macros.fibers, color: Color.amareloFibras)
                MacroCircle(value: macros.carbohydrates, color: Color.amareloCarboidratos)
                MacroCircle(value: macros.proteins, color: Color.rosaProteinas)
            }
        }
    }
}

struct MacroNutrientsView_Previews: PreviewProvider {
    static var previews: some View {
        // Aqui você pode definir um exemplo das macros que deseja visualizar
        let sampleMacros = Macronutrients(fats: 25, fibers: 30, carbohydrates: 50, proteins: 45)
        
        MacroNutrientsView(macros: sampleMacros)
            .padding()
            .background(Color.gray)// Define um fundo para ajudar na visualização dos elementos
    }
}
