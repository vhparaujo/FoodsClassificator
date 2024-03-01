//
//  IngredientSearchResponse.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 29/02/24.
//

import Foundation

struct IngredientSearchResponse: Decodable {
    let results: [Ingredient]
    let offset: Int
    let number: Int
    let totalResults: Int
}

// Modelo para um ingrediente
struct Ingredient: Decodable {
    let id: Int
    let name: String
    let image: String
}

// Modelo principal que representa a informação do ingrediente
struct IngredientInformation: Codable {
    let id: Int
    let original, originalName, name: String
    let amount: Double
    let unit, unitShort, unitLong: String
    let possibleUnits: [String]
    let estimatedCost: EstimatedCost
    let consistency: String
    let aisle: String
    let image: String
    let meta: [String]
    let nutrition: Nutrition
    let categoryPath: [String]
}

// Modelo para o custo estimado
struct EstimatedCost: Codable {
    let value: Double
    let unit: String
}

// Modelo para a nutrição
struct Nutrition: Codable {
    let nutrients: [Nutrient]
    let properties: [Property]
    let flavonoids: [Flavonoid]
    let caloricBreakdown: CaloricBreakdown
    let weightPerServing: WeightPerServing
}

// Modelo para nutrientes
struct Nutrient: Codable {
    let name: String
    let amount: Double
    let unit: String
    let percentOfDailyNeeds: Double
}

// Modelo para propriedades
struct Property: Codable {
    let name: String
    let amount: Double
    let unit: String
}

// Modelo para flavonoides
struct Flavonoid: Codable {
    let name: String
    let amount: Double
    let unit: String
}

// Modelo para a decomposição calórica
struct CaloricBreakdown: Codable {
    let percentProtein, percentFat, percentCarbs: Double
}

// Modelo para o peso por porção
struct WeightPerServing: Codable {
    let amount: Double
    let unit: String
}

