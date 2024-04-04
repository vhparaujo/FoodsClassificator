//
//  PerfilViewModel.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import Foundation
import CoreData

@Observable class PerfilViewModel {
    
    var userName: String = "Olá, Fulano!"
    var userPhoto: String = "labelImage"
    
    // variaveis do modal motivacional
    var alimento: String = "Chocolate"
    var dias: Int = 21
    var streak: Int = 3
    
}

class RefeicaoCoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    
    @Published var refeicoes: [Refeicao] = []
    
    init() {
        container = NSPersistentContainer(name: "Database")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error \(error)")
            } else {
                print("Successfully")
            }
        }
        
        fetchRefeicoes()
        
    }
    
    func fetchRefeicoes() {
        let request = NSFetchRequest<Refeicao>(entityName: "Refeicao")
        
        do {
            refeicoes = try container.viewContext.fetch(request)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func saveRefeicao(nome: String) {
        let newRefeicao = Refeicao(context: container.viewContext)
        newRefeicao.nome = nome
        
        do {
            try container.viewContext.save()
            fetchRefeicoes()
        } catch {
            print("Nao salvou \(error)")
        }
    }
    
    func deleteRefeicao(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let refeicao = refeicoes[index]
            container.viewContext.delete(refeicao)
        }
        
        do {
            try container.viewContext.save()
            fetchRefeicoes()
        } catch {
            print("Nao deletou \(error)")
        }
    }
    
}
