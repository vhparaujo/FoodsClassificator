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
    var frequenciaExercicio: Int
    var refeicoes: [String]
    
    // dados para motivation view
    var streak: Int
    var alimentos: [String]
    
    init(userName: String = "", userPhoto: Data = Data(), idade: Int = 0, peso: Int = 0, altura: Int = 0, sexoBiologico: String = "Masculino", objetivo: String = "", frequenciaExercicio: Int = 0, refeicoes: [String] = [], streak: Int = 0, alimentos: [String] = []) {
        self.userName = userName
        self.userPhoto = userPhoto
        self.idade = idade
        self.peso = peso
        self.altura = altura
        self.sexoBiologico = sexoBiologico
        self.objetivo = objetivo
        self.frequenciaExercicio = frequenciaExercicio
        self.refeicoes = refeicoes
        self.streak = streak
        self.alimentos = alimentos
    }
    
}
