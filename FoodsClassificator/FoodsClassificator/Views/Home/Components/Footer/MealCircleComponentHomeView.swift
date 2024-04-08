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
                .stroke()
                .foregroundStyle(.laranjaFundoHome)
//                .frame(width: 280)
            
            Circle()
                .foregroundStyle(.laranjaFundoHome)
                .overlay(content: {
                    VStack {
                        Spacer()
                        Text(mealText)
                            .foregroundStyle(.white)
                            .font(.system(size: 35))
                            .multilineTextAlignment(.center) // Alinhamento do texto ao centro
                            .padding(.horizontal) // Adiciona um preenchimento horizontal
                        
                        Spacer()
                        NavigationLink(destination: destinationView()) {
                            Image(systemName: "plus")
                                .foregroundStyle(.white)
                                .font(.system(size: 40))
                        }
                        Spacer()
                    }
                    .padding()
                    
                })
        }
    }
}

#Preview {
    HomeView()
}
