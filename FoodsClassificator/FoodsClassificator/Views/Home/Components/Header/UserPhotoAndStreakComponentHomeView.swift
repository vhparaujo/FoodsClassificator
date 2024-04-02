//
//  UserPhotoAndStreakComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 21/03/24.
//

import SwiftUI

struct UserPhotoAndStreakComponentHomeView: View {
    
    @Environment(HomeViewModel.self) var viewModel: HomeViewModel
    
    var body: some View {
        
        ZStack{
            
            HStack{
                Text("\(viewModel.streakNumber)")
                    .font(.callout)
                    .bold()
                    .foregroundStyle(Color.white)
                Image("fireSymbolHome")
                
                Spacer()
            }
            .frame(width: 80, height: 29)
            .padding(.horizontal)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.laranjaMacros, lineWidth: 1)
            )

            NavigationLink {
                MotivationView()
            } label: {
                Circle()
                    .overlay {
                        Image(viewModel.userPhoto)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle()
                            )
            
                    }
                    .frame(width: 45, height: 45)
                    .overlay {
                        Circle()
                            .stroke(lineWidth: 2)
                            .foregroundStyle(.white)
                    }
                    .offset(x: 35)
            }
            
        }
        
    }
}

#Preview {
    var viewModel = HomeViewModel()
    return UserPhotoAndStreakComponentHomeView()
        .environment(viewModel)
}
