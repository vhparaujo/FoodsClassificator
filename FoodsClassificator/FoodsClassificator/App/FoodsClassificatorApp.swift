//
//  FoodsClassificatorApp.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 24/02/24.
//

import SwiftUI
import SwiftData

@main
@MainActor
struct FoodsClassificatorApp: App {
    
    @AppStorage("onBoardingViewed") var onBoardingViewed = false
    @AppStorage("tutorialViewed") var tutorialViewed = false
    
    var containerModel: ModelContainer = .appContainer
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if onBoardingViewed == false {
                    OnBoardingPageControl()
                        .preferredColorScheme(.light)
                }
                else{
                    HomeView()
                        .preferredColorScheme(.light)
                }
            }.ignoresSafeArea(.keyboard)
        }.modelContainer(containerModel)
    }
}

@MainActor
extension ModelContainer {
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
