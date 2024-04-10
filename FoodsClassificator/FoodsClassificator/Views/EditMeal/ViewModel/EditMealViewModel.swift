//
//  EditMealViewModel.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 09/04/24.
//

import Foundation

class EditMealViewModel: ObservableObject {
    @Published var isExpanded: Bool = false
    @Published var meal: Meal
    @Published var foodDetails: [String: FoodDetail] 

    init(meal: Meal) {
        self.meal = meal
        self.foodDetails = meal.foodDetails
    }

    func updateMeal(name: String, totalCalories: Int, macros: Macronutrients) {
        // Atualiza os detalhes da refeição e notifica os observers
        meal.mealName = name
        meal.totalCalories = totalCalories
        meal.macros = macros
    }

    func addOrUpdateFoodDetail(name: String, detail: FoodDetail) {
        // Adiciona ou atualiza um detalhe de alimento
        foodDetails[name] = detail
    }

    func removeFoodDetail(name: String) {
        // Remove um detalhe de alimento
        foodDetails.removeValue(forKey: name)
    }
}
