//
//  TutorialPage1.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 04/04/24.
//

import SwiftUI

struct TutorialPage1: View {
    var body: some View {
        GeometryReader { geometry in
            Image("tutorial1")
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width, height: geometry.size.height)
            //                .clipped()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    TutorialPage1()
}
