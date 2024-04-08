//
//  FooterHomeViewModel.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 03/04/24.
//

import Foundation
import Observation
import Combine

@Observable
class FooterHomeViewModel {
    
    //MARK: rectangle
    var isBottleSelected = true
    
    var litersSelected: Double = 2.0
    var milliliterSelected: Double = 0.0
    var capacitySelected = 200.0
    
    var waterIntakeTotal: Double = 0.0
    var waterIntakeTotalFormatted: String {
        String(format: "%.1f", waterIntakeTotal / 1000.0)
    }
    
    // Calcula o total de água selecionada em ml
    var totalWaterSelectedInML: Double {
        (litersSelected * 1000) + milliliterSelected
    }
    
    // Calcula a porcentagem de água consumida em relação ao total selecionado
    var waterIntakePercentage: Double {
        guard totalWaterSelectedInML > 0 else { return 0 }
        return (waterIntakeTotal / totalWaterSelectedInML)
    }
    
    // Calcula quantas bolinhas preencher baseado na porcentagem de água consumida
    var filledCircles: Int {
        let percentage = waterIntakePercentage
        return Int(percentage * 4) // Como temos 4 bolinhas
    }
    
    func addWaterIntake() {
        waterIntakeTotal += Double(capacitySelected)
    }
    
    //MARK: Modal
    let litersOptions = Array(stride(from: 1, through: 15, by: 1))
    let milliliterOptions = Array(stride(from: 0, through: 950, by: 50))
    let capacityOptions = Array(stride(from: 50, through: 5000, by: 50))
    
    
    // Propriedade computada para calcular a soma de litros e mililitros
    var totalWaterInLiters: Double {
        litersSelected + (milliliterSelected / 1000.0)
    }
    
    // Propriedade computada para formatar a soma de litros e mililitros
    var formattedTotalWater: String {
        String(format: "%.2f", totalWaterInLiters)
    }
    
    var formattedCapacity: String {
        String(format: "%.0f ml", capacitySelected)
    }
    
}
