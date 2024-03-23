//
//  ProgressBar.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 23/03/24.
//

import SwiftUI

struct ProgressBar: View {
    var value: Double
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 45)
                .fill(Color.gray.opacity(0.5))
                .frame(height: 20)
                .overlay(
                    RoundedRectangle(cornerRadius: 45)
                        .fill(Color.green)
                        .frame(width: geometry.size.width * value, height: 20)
                )
        }
    }
}
