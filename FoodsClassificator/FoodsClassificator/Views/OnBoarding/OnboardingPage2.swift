//
//  OnboardingPage2.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 01/04/24.
//

import SwiftUI

struct OnboardingPage2: View {
    var body: some View {
        VStack{
            Image("Page2")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            Text("Vamos celebrar suas conquistas")
                .multilineTextAlignment(.center)
                .font(.system(size: 18))
                .bold()
                .padding(.horizontal)
            
            Text("Cada passo dado em direção a uma vida mais saudável é motivo de comemoração")
                .multilineTextAlignment(.center)
                .font(.system(size: 18))
                .frame(alignment: .center)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    OnboardingPage2()
}
