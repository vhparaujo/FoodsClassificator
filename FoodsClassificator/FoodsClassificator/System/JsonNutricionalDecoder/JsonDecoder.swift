//
//  JsonDecoder.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 20/03/24.
//

import Foundation

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
}
