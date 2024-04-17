//
//  HomeView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 20/03/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var homeViewModel = HomeViewModel()
    @State var perfilViewModel = PerfilViewModel()
    @State var footerViewModel = FooterHomeViewModel()

    
    var body: some View {
        
        VStack{
            HeaderView(homeViewModel: homeViewModel, perfilViewModel: perfilViewModel)
            Spacer()
            
            FooterView(footerHomeViewModel: footerViewModel, homeViewModel: homeViewModel)
                .background(Image("backgroundHome"))
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    HomeView()
}
