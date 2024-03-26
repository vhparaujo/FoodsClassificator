//
//  RecentMeal.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 23/03/24.
//

import Foundation

struct FoodDetail: Identifiable {
    let id = UUID()
    let calories: Int
    let macros: Macronutrients
}

struct Macronutrients {
    var fats: Double
    var fibers: Double
    var carbohydrates: Double
    var proteins: Double
}

struct Meal: Identifiable {
    let id = UUID()
    let mealName: String
    let image: String
    let totalCalories: Int
    let macros: Macronutrients
    let foodDetails: [String: FoodDetail]
}
