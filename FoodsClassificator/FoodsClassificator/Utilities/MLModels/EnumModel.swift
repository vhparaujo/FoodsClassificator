//
//  File.swift
//  FoodsClassificator
//
//  Created by Arthur Dos Reis on 10/04/24.
//

import Foundation

enum FoodItem: String, CaseIterable {
    case apple = "FRU1123A"
    case banana = "FRU0220B"
    case beans = "LEG0123C"
    case beef = "CAR0035A"
    case bread = "CER0097A"
    case cheese = "LAC0065B"
    case chicken = "CAR0032A"
    case coffee = "BEB0021A"
    case egg = "OVU0010A"
    case fish = "PEC0020A"
    case meat = "CAR0032L"
    case orange = "FRU0015A"
    case pasta = "CER0030A"
    case potatoes = "LEG0012A"
    case rice = "CER0348Z"
    case tomato = "LEG0015A"
    
    // Método para encontrar o código pelo nome do item
    static func findCodeByName(_ name: String) -> String? {
        for item in FoodItem.allCases where "\(item)" == name {
            return item.rawValue
        }
        return nil
    }
}

//static func mapStringToFoodItem(_ string: String) -> String? {
//    switch string {
//    case "apple": return FoodItem.apple.rawValue
//    case "banana": return FoodItem.banana.rawValue
//    case "beans": return FoodItem.beans.rawValue
//    case "beef": return FoodItem.beef.rawValue
//    case "bread": return FoodItem.bread.rawValue
//    case "cheese": return FoodItem.cheese.rawValue
//    case "chicken": return FoodItem.chicken.rawValue
//    case "coffee": return FoodItem.coffee.rawValue
//    case "egg": return FoodItem.egg.rawValue
//    case "fish": return FoodItem.fish.rawValue
//    case "meat": return FoodItem.meat.rawValue
//    case "orange": return FoodItem.orange.rawValue
//    case "pasta": return FoodItem.pasta.rawValue
//    case "potatoes": return FoodItem.potatoes.rawValue
//    case "rice": return FoodItem.rice.rawValue
//    case "tomato": return FoodItem.tomato.rawValue
//    default: return nil
//    }
//}
