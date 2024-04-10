//
//  AddMealViewModel.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 05/04/24.
//

import Foundation

class AddMealViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedFoods: [Food] = []
    @Published var selectedSegment: Int = 0
    @Published var isExpanded: Bool = false
    @Published var haveCurrentMeal = false
    
    @Published var foodData = FoodData()

    var filteredFoods: [Food] {
        foodData.searchFoodByName(searchText)
    }

    func addFoodToSelected(food: Food) {
        if !selectedFoods.contains(where: { $0.id == food.id }) {
            DispatchQueue.main.async {
                self.selectedFoods.append(food)
            }
        }
    }
    
    func addFoodCodesToSelect(foodCodes:[String]){
        selectedFoods = foodData.searchFoodFromModel(foodCodes)
    }

    func loadFoods() {
        Task {
            do {
                try await foodData.loadJson()
            } catch {
                print(error.localizedDescription) // Trate o erro conforme necessário
            }
        }
    }
    

}

