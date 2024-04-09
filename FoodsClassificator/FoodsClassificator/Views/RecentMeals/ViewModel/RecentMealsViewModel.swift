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
        print("Definindo a refeição atual para: \(meal)")
        currentMeal = meal
    }
    
    func deleteMeal(_ mealID: UUID) {
        recentMeals.removeAll { $0.id == mealID }
    }
    
    func editMeal(_ mealID: UUID, with newMeal: Meal) {
        if let index = recentMeals.firstIndex(where: { $0.id == mealID }) {
            recentMeals[index] = newMeal
        }
    }
}

