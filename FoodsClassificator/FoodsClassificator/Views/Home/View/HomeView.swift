//
//  HomeView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 20/03/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.dismiss) private var dismiss

    var viewModel = HomeViewModel()
    var footerHomeViewModel = FooterHomeViewModel()
    
    var body: some View {
        
        VStack {
            HeaderView()
                .environment(viewModel) 
                
            FooterView()
                .environment(footerHomeViewModel)
                .background(Image("backgroundHome"))
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
