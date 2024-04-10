//
//  FoodsClassificatorApp.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 24/02/24.
//

import SwiftUI
import SwiftData

@main
struct FoodsClassificatorApp: App {
    let modelcontent: ModelContainer = .appContainer
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TutorialHomeView()
                    .preferredColorScheme(.light)
            }
            .environment(PerfilViewModel())
            .environment(HomeViewModel())

        }.modelContainer(modelcontent)
    }
}



extension ModelContainer {
    @MainActor
   static let appContainer: ModelContainer = {

        do {
            
            let container = try ModelContainer(for: PerfilModel.self)
            
            var fetchDescriptor = FetchDescriptor<PerfilModel>()
            fetchDescriptor.fetchLimit = 1
            
            guard try container.mainContext.fetch(fetchDescriptor).count == 0 else { return container }
            
            var photo: UIImage = UIImage(named: "labelPerfil")!

            // Converta a imagem em dados, por exemplo, em formato PNG
            guard let imageData = photo.pngData() else {
                fatalError("Não foi possível converter a imagem em dados.")
            }
            
            let perfil = PerfilModel(userPhoto: imageData)
            
            container.mainContext.insert(perfil)
            
            return container
            
        } catch {
            fatalError("Failed to create container")
        }
        
    }()
}
