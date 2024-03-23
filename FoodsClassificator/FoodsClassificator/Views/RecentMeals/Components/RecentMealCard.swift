//
//  RecentMealCard.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 23/03/24.
//

import SwiftUI

struct RecentMealCard: View {
    var meal: Meal
    var onAddButtonPressed: () -> Void  // Closure que será chamada quando o botão for pressionado
    
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
            
            Button(action: onAddButtonPressed) {  // Chamada da closure aqui
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

