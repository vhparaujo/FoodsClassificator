//
//  MacroCircle.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 23/03/24.
//

import SwiftUI

struct MacroCircle: View {
    var value: Double
    var color: Color

    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let circleSize = screenWidth * 0.14 // Define o tamanho do círculo como antes

        ZStack {
            Circle()
                .fill(color)
                .frame(width: circleSize, height: circleSize)
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                )
            Text(String(format: "%.2f", value))
                .foregroundColor(.white)
                .bold()
        }
    }
}

struct MacroCircle_Previews: PreviewProvider {
    static var previews: some View {
        // Este é um exemplo de como a MacroCircle pode ser visualizada
        // com um label específico, um valor e uma cor.
        MacroCircle(value: 65, color: .blue)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray)
    }
}
