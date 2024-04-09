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
            }
            HStack {
                MealsCarrouselHomeView()
            }.padding(.bottom)
            
            HStack {
                Spacer()
                WaterRectangleComponentHomeView()
                Spacer()
            }
               
        }
        

    }
    
}

#Preview {
    var viewModel = FooterHomeViewModel()
    return FooterView()
        .environment(viewModel)
}
