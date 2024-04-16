//
//  PerfilModel.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 02/04/24.
//

import SwiftUI
import SwiftData

@Model class PerfilModel {
    
    var userName: String
    var userPhoto: Data
    var idade: Int
    var peso: Int
    var altura: Int
    var sexoBiologico: String
    var objetivo: String
    var intensidadeDoExercicio: String
    var refeicoes: [String]
    var temNutricionista: Bool
    var totalCalories: Int
    
    // dados para motivation view
    
    var streak: Int
    var alimentos: [String]
    
    var litersSelected: Double
    var milliliterSelected: Double
    var capacitySelected: Double
    var waterIntakeTotal: Double
    
    
    init(userName: String = "", userPhoto: Data = Data(), idade: Int = 0, peso: Int = 0, altura: Int = 0, sexoBiologico: String = "", objetivo: String = "", intensidadeDoExercicio: String = "", refeicoes: [String] = ["Café da manhã", "Almoço", "Jantar"], streak: Int = 0, alimentos: [String] = [], temNutricionista: Bool = false, totalCalories: Int = 2000, litersSelected: Double = 2.0, milliliterSelected: Double = 0.0, capacitySelected: Double = 200.0,  waterIntakeTotal: Double = 0.0 ) {
        self.userName = userName
        self.userPhoto = userPhoto
        self.idade = idade
        self.peso = peso
        self.altura = altura
        self.sexoBiologico = sexoBiologico
        self.objetivo = objetivo
        self.intensidadeDoExercicio = intensidadeDoExercicio
        self.refeicoes = refeicoes
        self.streak = streak
        self.alimentos = alimentos
        self.temNutricionista = temNutricionista
        self.totalCalories = totalCalories
        self.litersSelected = litersSelected
        self.milliliterSelected = milliliterSelected
        self.capacitySelected = capacitySelected
        self.waterIntakeTotal = waterIntakeTotal
    }
}
