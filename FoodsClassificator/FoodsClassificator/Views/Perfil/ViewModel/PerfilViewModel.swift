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
    var progress: Double = 0.16

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
        get {
            if let idade = model.idade {
               return String(idade)
            }
            return ""

        }
        set { model.idade = Int(newValue) ?? model.idade }
    }
    
    var pesoAsString: String {
        get {
            if let peso = model.peso {
                return String(peso)
            }
            return ""
        }
        set { model.peso = Double(newValue) ?? model.peso }
    }
    
    var alturaAsString: String {
        get {
            if let altura = model.altura {
                return String(altura)
            }
            return ""
        }
        set { model.altura = Int(newValue) ?? model.altura }
    }
    
    var selectedIntensityIndex: Int = 0
    
    func caloriesPerDay() -> Double {
        let genderFactor = model.sexoBiologico == "Masculino" ? 5 : -161
        
        var weight: Double = 0
        if let peso = model.peso {
            weight = peso
        }
        
        var height: Double = 0
        if let altura = model.altura {
            height = Double(altura)
        }
        
        var age: Double = 0
        if let idade = model.idade {
            age = Double(idade)
        }
        
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
