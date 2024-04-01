//
//  OnboardingPage1.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 01/04/24.
//

import SwiftUI

struct OnboardingPage1: View {
    var body: some View {
        VStack {
            Image("Page1")
                .resizable()
                .scaledToFit()
            
            Spacer()

            Text("Comece sua jornada de bem-estar com Papaia")
                .multilineTextAlignment(.center)
                .font(.system(size: 18))
                .bold()
                .padding(.horizontal)
            
            Text("Investir em uma alimentação saudável é investir em você mesmo")
                .multilineTextAlignment(.center)
                .font(.system(size: 18))
                .frame(alignment: .center)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    OnboardingPage1()
}
