//
//  MealCircleComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 21/03/24.
//

import SwiftUI

struct MealCircleComponentHomeView: View {
    let mealText: String // Texto do botão
    let destinationView: () -> AnyView // Ação a ser executada quando o botão é pressionado
    @Environment(\.dismiss) private var dismiss

    init(mealText: String, destinationView: @escaping () -> AnyView) {
        self.mealText = mealText
        self.destinationView = destinationView
    }
    
    var body: some View {
        
        ZStack {
        
            Circle()
                .foregroundStyle(.laranjaBrilhante)
                .overlay(content: {
                    VStack {
                        Spacer()
                        Text(mealText)
                            .foregroundStyle(.black)
                            .font(.largeTitle)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center) // Alinhamento do texto ao centro
                            .padding(.horizontal) // Adiciona um preenchimento horizontal
                        
                        Spacer()
                        NavigationLink(destination: destinationView()) {
                            Image(systemName: "plus")
                                .foregroundStyle(.black)
                                .font(.title)
                                .minimumScaleFactor(0.3)
                                
                        }
                        Spacer()
                    }
                    .padding()
                    
                })
            
                .overlay {
                    Circle()
                        .stroke(lineWidth: 10)
                        .foregroundStyle(.laranjaBrilhante)
                }
                .overlay {
                    Circle()
                        .stroke(lineWidth: 9)
                        .foregroundStyle(.windowBackground)
                }
        }
    }
}

#Preview {
    MealCircleComponentHomeView(mealText: "Café da Manhã") {
        print("Adicionar alimento")
    }
}
//#Preview {
//    HomeView()
//}
