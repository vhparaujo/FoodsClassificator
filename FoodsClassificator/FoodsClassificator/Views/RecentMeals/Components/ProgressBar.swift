//
//  ProgressBar.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 23/03/24.
//

import SwiftUI

struct ProgressBar: View {
    var value: Double // Valor entre 0.0 e 1.0 indicando a porcentagem do progresso
    
    // Usando UIScreen para definir a largura total da barra de progresso
    private let totalWidth = UIScreen.main.bounds.width * 0.35 // Definindo a largura como 80% da largura da tela

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 21)
                .fill(Color.verdeFundo)
                .frame(width: totalWidth * 1.2, height: 14)
            
            RoundedRectangle(cornerRadius: 21)
                .fill(Color.white)
                .frame(width: totalWidth, height: 10) // Largura total da barra de fundo
                .overlay(
                    RoundedRectangle(cornerRadius: 21)
                        .fill(Color.green) // Altere conforme necessário
                        .frame(width: totalWidth * value, height: 10) // Largura proporcional ao valor
                )
        }
        .frame(width: totalWidth, alignment: .leading) // Garantindo que o alinhamento seja feito à esquerda
    }
}
