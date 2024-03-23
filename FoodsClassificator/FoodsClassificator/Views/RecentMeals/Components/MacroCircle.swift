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
    
    var body: some View {
        VStack {
            Text(label)
            Text("\(value)")
        }
        .frame(width: 50, height: 50)
        .overlay(Circle().strokeBorder())
    }
}
