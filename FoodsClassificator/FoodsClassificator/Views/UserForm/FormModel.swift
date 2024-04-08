//
//  FormModel.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import Foundation
import SwiftData

//@Model
struct FormModel{
    
    var id: UUID {
        return UUID()
    }
    let name: String
    
    let age: String
    let weight: String
    let height: String
    
    let sex: sex
    enum sex: String {
        case male = "Male"
        case female = "Female"
    }
    
    var objective:String
    var exercisePerWeek:String
    
    var haveNutritionist:Bool
    var numberOfMeals:String
    var caloriesPreset:String
    
    init(name: String, age: String, weight: String, height: String, sex: sex, objective: String, exercisePerWeek: String, haveNutritionist: Bool, numberOfMeals: String, caloriesPreset: String) {
        self.name = name
        self.age = age
        self.weight = weight
        self.height = height
        self.sex = sex
        self.objective = objective
        self.exercisePerWeek = exercisePerWeek
        self.haveNutritionist = haveNutritionist
        self.numberOfMeals = numberOfMeals
        self.caloriesPreset = caloriesPreset
    }
    
}

