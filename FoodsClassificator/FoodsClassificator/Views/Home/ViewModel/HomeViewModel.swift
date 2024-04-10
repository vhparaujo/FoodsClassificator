//
//  HomeViewModel.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 20/03/24.
//

import SwiftUI

@Observable class HomeViewModel {
    var totalMeals: Meal?
    var userName: String = "Olá, Fulano!"
    var userPhoto: String = "labelImage"
    var macrosValue: Int = 100
    var streakNumber: Int = 20
    var calories: Int = 2896
    
    var progressBarValue: Double = 0.7
    
    var maxProgressBarValue: Double = 0.88
    var initialProgressBarValue: Double = 0.12
    
    init() {
        maxProgressBarValueFunc()
    }
    
    func maxProgressBarValueFunc() {
        if self.progressBarValue > maxProgressBarValue {
            self.progressBarValue = initialProgressBarValue
        }
    }
    
    func setTotalMeal(_ meal: Meal) {
        print("Definindo a refeição atual para: \(meal)")
        totalMeals = meal
    }
    
}
