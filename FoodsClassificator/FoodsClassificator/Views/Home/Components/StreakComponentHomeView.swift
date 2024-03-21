//
//  StreakComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 21/03/24.
//

import SwiftUI

struct StreakComponentHomeView: View {
    
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        Circle()
            .overlay {
                Text("\(viewModel.streakNumber)")
                Image("fireSymbolHome")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
            }
            .frame(width: 45, height: 45)
    }
}

#Preview {
    StreakComponentHomeView()
}
