//
//  RecentMealCard.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 23/03/24.
//

import SwiftUI

struct RecentMealCard: View {
    @Binding var haveCurrentMeal: Bool
    var meal: Meal
    var onAddButtonPressed: () -> Void  // Closure que será chamada quando o botão for pressionado
    
    var screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        HStack {
            Image(meal.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(meal.mealName)
                    .font(.headline)
                Text("\(Int(meal.totalCalories)) Cal")
                    .font(.subheadline)
            }
            
            Spacer()
            
            if haveCurrentMeal == false {
                Button(action: onAddButtonPressed) {  // Chamada da closure aqui
                    Image(systemName: "plus.circle")
                        .foregroundColor(.black)
                        .font(.title)
                }
            }
        }
        .padding()
        .background(Color.laranjaMacros)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

// Pré-visualização da RecentMealCard
struct RecentMealCard_Previews: PreviewProvider {
    static var previews: some View {
        @State var have = false
        // Criando um exemplo de Meal
        let exampleMeal = Meal(mealName: "Café da Manhã Saudável",
                               image: "breakfast",  // Certifique-se de ter essa imagem no seu asset catalog ou use uma imagem de sistema
                               totalCalories: 300,
                               macros: Macronutrients(fats: 10, fibers: 5, carbohydrates: 20, proteins: 15),
                               foodDetails: [:])  // O dicionário de detalhes de comida pode ficar vazio para a pré-visualização
        
        // Renderizando a RecentMealCard com o Meal de exemplo
        RecentMealCard(haveCurrentMeal: $have, meal: exampleMeal, onAddButtonPressed: {
            print("Adicionar refeição pressionado.")
        })
        .previewLayout(.sizeThatFits)
        .padding(20)
        .background(Color.black)
    }
}
