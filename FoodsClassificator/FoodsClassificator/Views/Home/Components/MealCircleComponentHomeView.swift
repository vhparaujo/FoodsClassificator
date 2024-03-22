//
//  MealCircleComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 21/03/24.
//

import SwiftUI

struct MealCircleComponentHomeView: View {
    let mealText: String // Texto do botão
    let buttonAction: () -> Void // Ação a ser executada quando o botão é pressionado
    
    var body: some View {
    
        ZStack {
            Circle()
                .stroke()
                .foregroundStyle(.orange)
                .frame(width: 220)
            
            Circle()
                .foregroundStyle(.orange)
                .overlay(content: {
                    VStack {
                        Spacer()
                        Text(mealText)
                            .foregroundStyle(.white)
                            .font(.system(size: 40))
                            .multilineTextAlignment(.center) // Alinhamento do texto ao centro
                            .padding(.horizontal) // Adiciona um preenchimento horizontal
                        
                        Spacer()
                        Button(action: buttonAction) {
                            Image(systemName: "plus")
                                .foregroundStyle(.white)
                                .font(.system(size: 40))
                        }
                        Spacer()
                    }
                    .padding()
                    
                })
                .frame(width: 200)
        }

    }
}

#Preview {
    MealCircleComponentHomeView(mealText: "Café da Manhã") {
        print("Adicionar alimento")
    }
}
