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
            NavigationLink(destination: FormsPage1()
                .environment(PerfilViewModel())
) {
                NextButtonLabel(nextButtonLabel: "Próximo")
            }

        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
        HomeView()
}
