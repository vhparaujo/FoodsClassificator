//
//  Header.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 23/03/24.
//

import SwiftUI

struct HeaderMealView: View {
    var meal: Meal
    var title: String
    @Binding var isExpanded: Bool

    // Utilizando UIScreen para obter a largura e a altura da tela
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundStyle(.white)
                .bold()
                .padding()
            
            if isExpanded {
                CircularProgressBar()
                    .padding(.top, -screenWidth * 0.06)
            } else {
                ProgressBar(value: Double(meal.totalCalories / 2000))
                
                Text("\(meal.totalCalories) \(HomeTexts.caloriasMinusculo)")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(.white)
            }
            
            
            if isExpanded {
                MacroNutrientsView(macros: meal.macros)
            }
            
            Spacer()
        }
        .animation(.easeInOut, value: isExpanded)
        .background(Color.verdeFundo)
        .padding(.top, -screenHeight * 0.02)
    }
}

// PreviewProvider para a HeaderMealView
struct HeaderMealView_Previews: PreviewProvider {
    @State static var isExpanded = true // Controla a expansão para o exemplo
    
    static var previews: some View {
        // Criando um exemplo de refeição
        let sampleMeal = Meal(mealName: "Café da Manhã",
                              image: "breakfast",
                              totalCalories: 650,
                              macros: Macronutrients(fats: 30, fibers: 10, carbohydrates: 80, proteins: 25), foodDetails: [:])
        
        HeaderMealView(meal: sampleMeal, title: "Café da Manhã", isExpanded: $isExpanded)
            .previewLayout(.sizeThatFits) // Configuração para exibir o preview em um tamanho adequado
    }
}
