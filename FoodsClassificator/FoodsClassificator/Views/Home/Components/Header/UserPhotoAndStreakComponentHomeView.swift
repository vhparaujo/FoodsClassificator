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
        
        NavigationLink {
            MotivationView()
        } label: {
        
        ZStack{

            HStack{
                Text("\(viewModel.streakNumber)")
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

           
                Circle()
                    .overlay {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.gray)
                            .clipShape(Circle()
                            )
            
                    }
                    .frame(width: 45, height: 45)
                    .overlay {
                        Circle()
                            .stroke(lineWidth: 2)
                            .foregroundStyle(.verdeTitle)
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
