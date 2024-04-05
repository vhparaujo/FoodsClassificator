//
//  HomeView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 20/03/24.
//

import SwiftUI

struct HomeView: View {
    
    var viewModel = HomeViewModel()
   
    var body: some View {
            
            VStack {
                
                HeaderView()
                    .environment(viewModel)
                
                HStack {
                    Spacer()
                    DatePickerComponentHomeView()
                }
                
                MealsCarrouselHomeView()
                
                WaterRectangleComponentHomeView()
                
            }
        
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
