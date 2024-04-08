//
//  FooterView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 03/04/24.
//

import SwiftUI

struct FooterView: View {
    //    @Environment(HomeViewModel.self) var viewModel
    @Environment(FooterHomeViewModel.self) var footerHomeViewModel
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
                DatePickerComponentHomeView()
                    .padding(.horizontal)
            }
            
            MealsCarrouselHomeView()
            
            WaterRectangleComponentHomeView()
                .padding(.horizontal)
        }
        .background(
            Image("backgroundHome")
            .resizable()
            .scaledToFill()
        )
    }
}

#Preview {
    var viewModel = FooterHomeViewModel()
    return FooterView()
        .environment(viewModel)
}
