//
//  FormViewModel.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import Foundation

@Observable
class FormViewModel {
    var id: UUID {
        return UUID()
    }
    let name: String = ""
    
    let age: String = ""
    let weight: String = ""
    let height: String = ""
    
    let sex: String = ""
    enum sex: String {
        case male = "Male"
        case female = "Female"
    }
    
    var objective:String = ""
    var exercisePerWeek:String = ""
    
    var haveNutritionist:Bool = false
    var numberOfMeals:String = ""
    var caloriesPreset:String = ""
    
}
