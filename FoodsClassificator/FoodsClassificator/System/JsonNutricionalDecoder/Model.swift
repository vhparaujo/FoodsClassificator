//
//  Model.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 20/03/24.
//

import Foundation

struct Food: Identifiable, Codable, Hashable {
    
    var id: UUID {
        return UUID()
    }
    
    let codigo: String
    let nome: String
    let grupo: String
    let marca: String
    let detalhesNutricionais: [Details]
    
    enum CodingKeys: String, CodingKey {
        case codigo = "Código"
        case nome = "Nome"
        case grupo = "Grupo"
        case marca = "marca"
        case detalhesNutricionais = "Detalhes Nutricionais"
    }
}

struct Details: Identifiable ,Codable, Hashable {
    
    var id: UUID {
        return UUID()
    }
    
    let componente: String
    let unidade: String
    let valor: String

    enum CodingKeys: String, CodingKey {
        case componente = "Componente"
        case unidade = "Unidade"
        case valor = "Valor por 100g"
    }
    
}
