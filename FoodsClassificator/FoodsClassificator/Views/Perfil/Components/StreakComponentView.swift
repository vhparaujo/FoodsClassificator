//
//  StreakComponentView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftUI

struct StreakComponentView: View {
    
    @State var dias: Int = 0
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                Text("\(dias) \(PerfilTexts.dias)")
                    .font(.title)
            }
            
            Spacer()
            
            Image("emoji1")
                .resizable()
                .frame(width: 70, height: 70)
        }.padding()
            .background(Color.laranjaBrilhante)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding(.horizontal)
        
    }
}

#Preview {
    StreakComponentView()
}
