//
//  HomeView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 20/03/24.
//

import SwiftUI

struct HomeView: View {
        
    var body: some View {
        NavigationStack {
            VStack {
                
                HeaderView()
                
                HStack {
                    Spacer()
                    DatePickerComponentHomeView()
                }
                
                MealsCarrouselHomeView()
                
                WaterRectangleComponentHomeView()
            }
        }
    }
}

#Preview {
    HomeView()
}
