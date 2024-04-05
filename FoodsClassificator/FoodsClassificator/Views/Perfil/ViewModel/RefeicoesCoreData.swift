////
////  RefeicoesCoreData.swift
////  FoodsClassificator
////
////  Created by Victor Hugo Pacheco Araujo on 05/04/24.
////
//
//import CoreData
//
//class RefeicaoCoreDataViewModel: ObservableObject {
//    let container: NSPersistentContainer
//    
//    @Published var refeicoes: [Refeicao] = []
//    
//    init() {
//        container = NSPersistentContainer(name: "Database")
//        container.loadPersistentStores { (description, error) in
//            if let error = error {
//                print("Error \(error)")
//            } else {
//                print("Successfully")
//            }
//        }
//        
//        fetchRefeicoes()
//        
//    }
//    
//    func fetchRefeicoes() {
//        let request = NSFetchRequest<Refeicao>(entityName: "Refeicao")
//        
//        do {
//            refeicoes = try container.viewContext.fetch(request)
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//    
//    func saveRefeicao(nome: String) {
//        let newRefeicao = Refeicao(context: container.viewContext)
//        newRefeicao.nome = nome
//        
//        do {
//            try container.viewContext.save()
//            fetchRefeicoes()
//        } catch {
//            print("Nao salvou \(error)")
//        }
//    }
//    
//    func deleteRefeicao(at indexSet: IndexSet) {
//        indexSet.forEach { index in
//            let refeicao = refeicoes[index]
//            container.viewContext.delete(refeicao)
//        }
//        
//        do {
//            try container.viewContext.save()
//            fetchRefeicoes()
//        } catch {
//            print("Nao deletou \(error)")
//        }
//    }
//    
//}
