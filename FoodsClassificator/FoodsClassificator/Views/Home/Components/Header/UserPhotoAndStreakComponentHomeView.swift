//
//  UserPhotoAndStreakComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 21/03/24.
//

import SwiftUI

struct UserPhotoAndStreakComponentHomeView: View {
    
    var viewModel: HomeViewModel?
    
    @Bindable private var perfilViewModel = PerfilViewModel()
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        
        NavigationLink {
            MotivationView()
        } label: {
        
        ZStack{

            HStack{
                Text("\(viewModel?.streakNumber)")
                    .font(.callout)
                    .bold()
                    .foregroundStyle(Color.verdeTitle)
                Image("fireSymbolHome")
                    .foregroundStyle(.black)
                
                Spacer()
            }
            .frame(width: 80, height: 29)
            .padding(.horizontal)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.verdeTitle, lineWidth: 1)
            )

            PerfilImageViewComponent(viewModel: perfilViewModel)
                    .frame(width: 45, height: 45)
                    .offset(x: 35)
            
            }
        .onAppear(perform: {
            perfilViewModel.modelContext = context
        })
            
        }
        
    }
}

//#Preview {
//    var viewModel = HomeViewModel()
//    return UserPhotoAndStreakComponentHomeView()
//        .environment(viewModel)
//}
