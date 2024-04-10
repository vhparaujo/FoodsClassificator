//
//  RecentMeal.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 23/03/24.
//

import Foundation

struct FoodDetail: Identifiable {
    let id = UUID()
    var calories: Int
    var macros: Macronutrients
}

struct Macronutrients {
    var fats: Double
    var fibers: Double
    var carbohydrates: Double
    var proteins: Double
}

struct Meal: Identifiable {
    let id = UUID()
    var mealName: String
    let image: String
    var totalCalories: Int
    var macros: Macronutrients
    var foodDetails: [String: FoodDetail]
}
