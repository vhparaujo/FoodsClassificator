//
//  PerfilViewModel.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import Foundation

@Observable class PerfilViewModel {
    
    var userName: String = "Olá, Fulano!"
    var userPhoto: String = "labelImage"
    var idade: Int = 21
    var peso: Double = 70.3
    var altura: Double = 1.75
    var genero: Genero = .masculino
    var objetivo: String = ""
    var frequenciaExercicio: String = ""
    
    // variaveis do modal motivacional
    var alimento: String = "Chocolate"
    var dias: Int = 21
    var streak: Int = 3

}

enum Genero: String {
    case masculino = "Masculino"
    case feminino = "Feminino"
}
