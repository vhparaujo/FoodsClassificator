//
//  FooterView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 03/04/24.
//

import SwiftUI

struct FooterView: View {
    
    var footerHomeViewModel = FooterHomeViewModel()
    var viewModel: HomeViewModel

    var body: some View {
        VStack{
            HStack {
                Spacer()
                DatePickerComponentHomeView()
            }.padding(.trailing)
            HStack {
                MealsCarrouselHomeView(viewModel: viewModel)
            }.padding(.bottom)
            
            HStack {
                Spacer()
                WaterRectangleComponentHomeView()
                Spacer()
            }
               
        }
        

    }
    
}

//#Preview {
//    var viewModel = FooterHomeViewModel()
//    return FooterView()
//        .environment(viewModel)
//}
