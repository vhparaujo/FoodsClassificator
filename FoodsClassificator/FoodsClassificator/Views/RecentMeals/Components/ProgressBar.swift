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
            RoundedRectangle(cornerRadius: 21)
                .fill(Color.white)
                .frame(height: 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 21)
                        .fill(Color.green)
                        .frame(width: geometry.size.width * value, height: 10)
                )
        }
    }
}
