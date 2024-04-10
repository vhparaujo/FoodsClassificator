//
//  OnBoardingPageControl.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 01/04/24.
//

import SwiftUI

struct OnBoardingPageControl: View {
    
    
    
    var body: some View {
        TabView{
            OnboardingPage1()
            OnboardingPage2()
            OnboardingPage3()
        }
        
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    OnBoardingPageControl()
}
