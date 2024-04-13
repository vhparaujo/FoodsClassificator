//
//  HomeView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 20/03/24.
//

import SwiftUI

struct HomeView: View {
    
    var viewModel = HomeViewModel()
    @State var perfilViewModel = PerfilViewModel()
    
    var body: some View {
        
        VStack{
            HeaderView(viewModel: viewModel, perfilViewModel: perfilViewModel)
            Spacer()
            
            FooterView(viewModel: viewModel)
                .background(Image("backgroundHome"))
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    HomeView()
}
