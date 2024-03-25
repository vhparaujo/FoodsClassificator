//
//  MacroCircle.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 23/03/24.
//

import SwiftUI

struct MacroCircle: View {
    var label: String
    var value: Double
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(label)
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                ZStack {
                    Circle()
                        .fill(color)
                        .frame(width: geometry.size.width * 0.44, height: geometry.size.width * 0.44)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                    
                    Text("\(Int(value))")
                        .foregroundColor(.white)
                }
            }
            .padding(geometry.size.width * 0.02) // Aplica um padding baseado em 5% da largura da tela
        }
    }
}
