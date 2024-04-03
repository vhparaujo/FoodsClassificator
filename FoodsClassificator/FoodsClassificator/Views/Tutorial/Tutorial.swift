//
//  Tutorial.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 03/04/24.
//

import SwiftUI

struct Tutorial: View {
    var body: some View {
        TabView{
            Image("home1")
            Image("home2")
            Image("home3")
            Image("home4")
        }
        .ignoresSafeArea()
        .frame(width: .infinity, height: .infinity)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .indexViewStyle(.page(backgroundDisplayMode: .never))
    }
}


#Preview {
    Tutorial()
}
