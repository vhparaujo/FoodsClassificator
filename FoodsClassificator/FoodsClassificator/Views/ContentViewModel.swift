//
//  ContentViewModel.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 01/03/24.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var nutritionDataToShow: NutritionData?
    
    func getIngredientID(query: String) {
        FoodAPIManager.searchIngredients(query: query, number: 1) { result in
            switch result {
            case .success(let searchResponse):
                print("API Success: Found \(searchResponse.results.count) ingredients")
                guard let firstIngredientId = searchResponse.results.first?.id else {
                    print("Error: No ingredients found")
                    return
                }
                self.getIngredientInfo(firstIngredientId: firstIngredientId)
            case .failure(let error):
                print("Error searching ingredients: \(error)")
            }
        }
    }
    
    func getIngredientInfo(firstIngredientId: Int) {
        FoodAPIManager.getIngredientInformation(id: firstIngredientId, amount: 1, unit: "grams") { result in
            switch result {
            case .success(let ingredientInfo):
                print("Ingredient Info Success")
                DispatchQueue.main.async {
                    print("Atualizando estados para apresentar modal.")
//                            print("Nutrients atualizados: \(ingredientInfo.nutrition.nutrients.map { $0.name })")
//                            print("Properties atualizadas: \(ingredientInfo.nutrition.properties.map { $0.name })")
                    
                    let newNutritionData = NutritionData(nutrients: ingredientInfo.nutrition.nutrients, properties: ingredientInfo.nutrition.properties)
                    self.nutritionDataToShow = newNutritionData
                    
                    print(self.nutritionDataToShow!)
                    
                    
                }
            case .failure(let error):
                print("Error fetching ingredient information: \(error)")
            }
        }
    }
}
