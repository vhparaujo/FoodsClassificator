//
//  nextButton.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 07/04/24.
//

import SwiftUI

struct NextButtonLabel: View {
    var label: String
    
    var body: some View {
        Text(label)
            .foregroundColor(.white)
            .font(.title2)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.laranjaFundoHome)
            .cornerRadius(20)
    }
}

#Preview {
    NextButtonLabel(label: "oi")
}
