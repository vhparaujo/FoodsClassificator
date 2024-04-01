//
//  MealViewModel.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 23/03/24.
//

import Foundation

class RecentMealsViewModel: ObservableObject {
    @Published var recentMeals: [Meal] = []
    @Published var currentMeal: Meal?
    
    func addMealToRecent(_ meal: Meal) {
        recentMeals.append(meal)
    }
    
    func setCurrentMeal(_ meal: Meal) {
        currentMeal = meal
    }
}

