//
//  FooterView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 03/04/24.
//

import SwiftUI

struct FooterView: View {
    @Environment(\.modelContext) private var context
    var footerHomeViewModel: FooterHomeViewModel
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
                WaterRectangleComponentHomeView(footerHomeViewModel: footerHomeViewModel)
                Spacer()
            }
               
        }
        .onAppear(perform: {
            footerHomeViewModel.modelContext = context
        })
        

    }
    
}

//#Preview {
//    var viewModel = FooterHomeViewModel()
//    return FooterView()
//        .environment(viewModel)
//}
