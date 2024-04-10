//
//  HomeView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 20/03/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.dismiss) private var dismiss    
    var body: some View {
        
        VStack{
            HeaderView()
                .padding(.bottom, -20)
            
            
            FooterView()
                .background(
                    Image("backgroundHome")
                        .resizable()
                        .scaledToFill()
                )
        }
        .navigationBarBackButtonHidden()
    }
}

//#Preview {
//        HomeView()
//}
