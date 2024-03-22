//
//  BarcodeSeachResponse.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 21/03/24.
//

import Foundation

// Estrutura de resposta da API do produto
struct ProductResponse: Codable {
    let product: Product
}

struct NutritionFacts: Codable {
    let fat: String
    let carbohydrates: String
    let protein: String
    let salt: String
}

struct Product: Codable {
    let brand: String?
    let images: [String]
    let ingredients: String?
    let nutritionFacts: String?
    let title: String

    enum CodingKeys: String, CodingKey {
        case brand, images, ingredients, nutritionFacts = "nutrition_facts", title
    }
    
    func parseNutritionFacts() -> NutritionFacts? {
        guard let nutritionString = nutritionFacts else {
            print("Depuração: nutritionFacts é nil")
            return nil
        }
        
        let nutritionComponents = nutritionString.split(separator: ",")
        var nutritionDict = [String: String]()

        for component in nutritionComponents {
            let parts = component.trimmingCharacters(in: .whitespaces).split(separator: " ", maxSplits: 2, omittingEmptySubsequences: true).map(String.init)
            if parts.count == 3, let nutrientName = parts.first, let value = parts.dropFirst().first, let unit = parts.last {
                let key = nutrientName
                let valueWithUnit = value + " " + unit
                nutritionDict[key] = valueWithUnit
            }
        }
        
        guard let fat = nutritionDict["Fat"],
              let carbohydrates = nutritionDict["Carbohydrates"],
              let protein = nutritionDict["Protein"],
              let salt = nutritionDict["Salt"] else {
            print("Depuração: Falha ao extrair todos os componentes necessários")
            return nil
        }
        
        return NutritionFacts(fat: fat, carbohydrates: carbohydrates, protein: protein, salt: salt)
    }
    
    func parseIngredientsToDictionary() -> [String: String]? {
        guard let ingredientsString = ingredients else {
            print("Depuração: nutritionFacts é nil")
            return nil
        }
        
        // Substituir "E/ou" por um placeholder único para evitar divisão incorreta
        let placeholder = "###"
        let preprocessedString = ingredientsString.replacingOccurrences(of: "E/ou", with: placeholder)
        
        // Dividir a string nos "E" que realmente significam separação de ingredientes
        let splitIngredients = preprocessedString.split(separator: "E ").map {
            $0.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: placeholder, with: "ou")
        }
        
        // Mapear os ingredientes para um dicionário com chaves no formato "ingredientN"
        var ingredientsDict = [String: String]()
        for (index, ingredient) in splitIngredients.enumerated() {
            ingredientsDict["ingredient\(index + 1)"] = ingredient
        }
        
        return ingredientsDict
    }
}

// Exemplo de chamada da api
//Button("Search Barcorde") {
//    print("button pressed")
//    BarcodeAPIManager.searchBarcode(query: "7896051164609") { result in
//        switch result {
//        case .success(let productResponse):
//            print("Sucesso! Produto encontrado: ")
//            
//            if let nutritionString = productResponse.product.nutritionFacts {
//                if let nutritionFacts = productResponse.product.parseNutritionFacts() {
//                    print("Fat: \(nutritionFacts.fat)")
//                    print("Carbohydrates: \(nutritionFacts.carbohydrates)")
//                    print("Protein: \(nutritionFacts.protein)")
//                    print("Salt: \(nutritionFacts.salt)")
//                } else {
//                    print("Falha ao parsear nutritionFacts")
//                }
//            } else {
//                print("nutritionFacts é nil")
//            }
//            
//            if let ingredientsString = productResponse.product.ingredients {
//                let ingredientsDict = productResponse.product.parseIngredientsToDictionary()
//                
//                // Iterar pelo dicionário de ingredientes e imprimir cada um
//                for (key, value) in ingredientsDict!.sorted(by: { $0.key < $1.key }) {
//                    print("\(key): \(value)")
//                }
//            } else {
//                print("ingredients é nil")
//            }
//            
//        case .failure(let error):
//            print("Erro ao buscar o produto: \(error.localizedDescription)")
//        }
//    }
//}
