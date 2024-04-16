//
//  QuestionTextComponent.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import SwiftUI
import SwiftData

struct QuestionTextComponent: View {
    var QuestionLabel: String
    
    var body: some View {
        VStack(alignment: .leading) { // Este VStack está alinhado à esquerda.
            Text(QuestionLabel)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading) // Alinha o texto à esquerda.
        }
        .frame(maxWidth: .infinity, alignment: .leading) // Garante que o VStack ocupe a largura total e alinhe seu conteúdo à esquerda.
    }
}

#Preview {
    QuestionTextComponent(QuestionLabel: "Isso vai ser uma Pergunta?")
}

//#Preview {
//    let modelContainer: ModelContainer = .appContainer
//    return FormsPage4().modelContainer(modelContainer)
//}
