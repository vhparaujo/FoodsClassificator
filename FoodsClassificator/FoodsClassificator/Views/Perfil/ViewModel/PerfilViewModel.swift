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
    
    var variacaoDaIdade = stride(from: 0, through: 120, by: 1).map { $0 }
    var variacaoDoPeso = stride(from: 0, through: 1000, by: 1).map { $0 }
    var variacaoDaAltura = stride(from: 0, through: 250, by: 1).map { $0 }
    
    let sexos: [String] = ["Masculino", "Feminino"]
    
    let objetivos: [String] = ["Perder peso", "Manter peso", "Ganhar peso", "Ganhar massa muscular", "Ter uma alimentação balanceada"]
    
    let refeicoesFixas: [String] = ["Café da manhã", "Almoço", "Jantar"]
    
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
        set { model.peso = Int(newValue) ?? model.peso }
    }
    
    var alturaAsString: String {
        get { String(model.altura) }
        set { model.altura = Int(newValue) ?? model.altura }
    }
}
