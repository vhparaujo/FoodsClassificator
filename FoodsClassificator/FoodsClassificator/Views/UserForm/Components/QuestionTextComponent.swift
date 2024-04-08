//
//  QuestionTextComponent.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import SwiftUI

struct QuestionTextComponent: View {
    var label: String
    
    var body: some View {
        Text(label)
            .font(.system(size: 20))
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)
            .padding()
    }

}

#Preview {
    QuestionTextComponent(label: "Isso vai ser uma Pergunta?")
}
