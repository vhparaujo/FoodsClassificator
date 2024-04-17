//
//  TipKitView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 10/04/24.
//

import SwiftUI

struct TipKitView: View {
    var body: some View {
        VStack {
            Text("Qual sexo biológico devo escolher?")
                .font(.title3)
                .foregroundStyle(.verdeTitle)
                .padding(.top)
            
            Text("Ao calcular suas necessidades calóricas diárias, a identidade de gênero que você seleciona é importante. Isso influencia as estimativas de calorias necessárias para seus objetivos de saúde. Se você está em transição de gênero e tomando medicamentos específicos, isso pode afetar sua escolha.")
                .padding(.vertical)
            
            Text("Recomendamos que você consulte seu médico para determinar qual opção é a mais adequada para calcular suas necessidades calóricas com precisão. Seu médico poderá levar em consideração sua identidade de gênero, histórico médico, estilo de vida e objetivos individuais para fornecer uma avaliação personalizada.")
            
            Spacer()
            
        }.padding()
        
     }
}

#Preview {
    TipKitView()
}
