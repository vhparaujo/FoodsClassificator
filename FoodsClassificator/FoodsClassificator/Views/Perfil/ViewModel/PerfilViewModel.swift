//
//  PerfilViewModel.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftData
import Foundation

@Observable class PerfilViewModel {
    
    var model = PerfilModel()
    
    var modelContext: ModelContext? {
        didSet {
            fetchData()
        }
    }

    let sexos: [String] = ["Masculino", "Feminino"]
    
    let objetivos: [String] = ["Perder peso", "Manter peso", "Ganhar peso", "Ganhar massa muscular", "Ter uma alimentação balanceada"]
        
    let intensidades: [String] = ["Sedentário", "Leve", "Moderado", "Intenso", "Muito Intenso"]
    
    var textFieldName = ""
    
    func fetchData() {
        
        guard let modelContext = self.modelContext else { return }
        
        do {
            
            let descriptor = FetchDescriptor<PerfilModel>()
            
            if let fetchedModel = try modelContext.fetch(descriptor).first {
                model = fetchedModel
            } else {
                fatalError("No data fetched")
            }
            
        } catch {
            fatalError("Fetch failed: \(error.localizedDescription)")
        }
        
    }
    var idadeAsString: String {
        get { String(model.idade) }
        set { model.idade = Int(newValue) ?? model.idade }
    }
    
    var pesoAsString: String {
        get { String(model.peso) }
        set { model.peso = Double(newValue) ?? model.peso }
    }
    
    var alturaAsString: String {
        get { String(model.altura) }
        set { model.altura = Int(newValue) ?? model.altura }
    }
    
    var selectedIntensityIndex: Int = 0
    
    func caloriesPerDay() -> Double {
        let genderFactor = model.sexoBiologico == "Masculino" ? 5 : -161
        let weight = model.peso
        let height = Double(model.altura)
        let age = Double(model.idade)
        // Array de multiplicadores de atividade correspondendo a "Sedentário", "Leve", "Moderado", "Intenso", "Muito Intenso"
        let activityMultipliers = [1.2, 1.375, 1.55, 1.725, 1.9]
        // Usa o selectedIndex para obter o multiplicador correto
        let activityMultiplier = activityMultipliers[selectedIntensityIndex]
        
        let bmr = (10 * weight) + (6.25 * height) - (5 * age) + Double(genderFactor)
        let calories = bmr * activityMultiplier
        print(calories)
        model.totalCalories = Int(calories)
        return calories
    }
    
}
