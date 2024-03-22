//
//  HomeView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 20/03/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            
            HStack {
                UserNameComponentHomeView()
                Spacer()
                
                UserPhotoComponentHomeView()
            }.padding()
            
            MacrosComponentHomeView(macroType: "Fibras")
            
            
            HStack {
                Spacer()
                DatePickerComponentHomeView()
            }
            
            MealsCarrouselHomeView()
            
            WaterRectangleComponentHomeView()
            Spacer()
            
        }
    }
}

#Preview {
    HomeView()
}
