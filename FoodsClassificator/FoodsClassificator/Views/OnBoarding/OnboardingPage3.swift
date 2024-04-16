//
//  OnboardingPage3.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 01/04/24.
//

import SwiftUI

struct OnboardingPage3: View {
    @AppStorage("onBoardingViewed") var onBoardingViewed: Bool?

    var body: some View {
        VStack {
            Image("Page3")
                .resizable()
                .scaledToFit()
            
            Spacer()

            Text("Registre suas refeições num piscar de olhos")
                .multilineTextAlignment(.center)
                .font(.system(size: 18))
                .bold()
                .padding(.horizontal)
            
            Text(" Tire uma foto da refeição e veja a mágica acontecer com a nossa IA")
                .multilineTextAlignment(.center)
                .font(.system(size: 18))
                .frame(alignment: .center)
                .padding()
            
            NavigationLink(destination: TutorialHomeView()) {
                NextButtonLabel(nextButtonLabel: "Iniciar tutorial")
            }.simultaneousGesture(TapGesture().onEnded{
                onBoardingViewed = true
            })
            .padding()

            
            Spacer()
        }
    }
}

#Preview {
    OnboardingPage3()
}
