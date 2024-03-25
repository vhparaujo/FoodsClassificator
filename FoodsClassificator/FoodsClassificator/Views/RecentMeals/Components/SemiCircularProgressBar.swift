//
//  SemiCircularProgressBar.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 23/03/24.
//

import SwiftUI

struct SemiCircularProgressBar: View {
    var value: CGFloat // Um valor entre 0 e 1

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Traça o arco de fundo
                Path { path in
                    path.addArc(center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height),
                                radius: geometry.size.width / 8,
                                startAngle: Angle(degrees: 120),
                                endAngle: Angle(degrees: 0),
                                clockwise: false)
                }
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                .opacity(0.3)
                .foregroundColor(Color.white)
                
                // Traça o arco de progresso
                Path { path in
                    path.addArc(center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height),
                                radius: geometry.size.width / 8,
                                startAngle: Angle(degrees: 120),
                                endAngle: Angle(degrees: Double(120 - (value * 120))),
                                clockwise: true)
                }
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                .foregroundColor(Color.white)

                // Posiciona o valor das calorias no centro inferior
                Text("\(Int(value * 100))")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .position(x: geometry.size.width / 2, y: geometry.size.height - 30)

                // Posiciona o texto 'Calorias' na base do semicírculo
                Text("Calorias")
                    .font(.caption)
                    .foregroundColor(Color.white)
                    .position(x: geometry.size.width / 2, y: geometry.size.height + 10)
            }
        }
    }
}
