//
//  JsonDecoder.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 20/03/24.
//

import Foundation
import SwiftUI

@Observable class FoodData {
    
    var foods: [Food] = []
    
    func loadJson() async throws {
        let decoder = JSONDecoder()
        guard let url = Bundle.main.url(forResource: "dados_alimentos_completo", withExtension: "json") else { throw Errors.invalidURL }
        
        do {
            let data = try Data(contentsOf: url)
            self.foods = try decoder.decode([Food].self, from: data)
        } catch {
            throw Errors.invalidData
        }
    }
    
    // Função para buscar alimentos pelo nome
    func searchFoodByName(_ name: String) -> [Food] {
        guard name.count >= 3 else { return [] }
        return foods.filter { $0.nome.lowercased().contains(name.lowercased()) }
    }
    
    func searchFoodFromModel(_ codeFood: [String]) -> [Food] {
        var saveJson: [Food] = []
        
        for name in codeFood {
            // Filtra os alimentos cujo código contém o nome atual, ignorando a diferença entre maiúsculas e minúsculas.
            let filteredFoods = foods.filter { $0.codigo.uppercased().contains(name.uppercased()) }
            
            // Adiciona os alimentos filtrados ao array de resultado.
            saveJson.append(contentsOf: filteredFoods)
        }
        print("\(foods.count)")
        print("searchFoodFromModel: \(saveJson)")
        print("searchFoodFromModel: \(codeFood)")
        
        return saveJson
    }
}
