//
//  HomeView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 20/03/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Bindable private var viewModel = PerfilViewModel()
    @Bindable private var footerHomeViewModel = FooterHomeViewModel()
    
    var body: some View {
        
        VStack{
            HeaderView()
                .environment(viewModel)
                .padding(.bottom, -20)
            
            
            FooterView()
                .environment(footerHomeViewModel)
                .background(
                    Image("backgroundHome")
                        .resizable()
                        .scaledToFill()
                )
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            viewModel.modelContext = context
        }
    }
}

//#Preview {
//        HomeView()
//}
