//
//  TutorialHomeView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 04/04/24.
//

import SwiftUI

struct TutorialHomeView: View {
    var body: some View {
        
        TabView {
            GeometryReader { /*geometry in*/
                let safeArea = $0.safeAreaInsets
                HStack {
                    VStack {
                        RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(Color.red)
                        RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(Color.green)
                        RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(Color.blue)
                        RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(Color.yellow)
                    }
                    VStack {
                        RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(Color.red)
                        RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(Color.green)
                        RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(Color.blue)
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 10))
                            .foregroundStyle(Color.yellow)
                    }
                }
                .overlay(alignment: .top, content: {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .frame(height: safeArea.top)
                })
                .ignoresSafeArea()
                .overlay(alignment: .topTrailing){
                    VStack{
                        Button{
                            
                        } label: {
                            Image(systemName: "pencil.circle")
                                .foregroundStyle(Color.white)
                                .padding(10)
                                .background{
                                    RoundedRectangle(cornerRadius: 10,
                                                     style: .continuous)
                                        .fill(.black)
                                }
                        }
                        
                        Spacer()
                        
                        Button{
                            
                        } label: {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(Color.red)
                                .padding(10)
                                .background{
                                    RoundedRectangle(cornerRadius: 10,
                                                     style: .continuous)
                                        .fill(.green)
                                }
                        }
                        
                    }
                    .padding(15)
                }
            }
            .tabItem {
                Image(systemName: "square.and.arrow.up")
                Text("Aba1")

            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.ultraThinMaterial, for: .tabBar)
            
            Text("")
                .tabItem {
                    Image(systemName: "square.and.arrow.up")
                    Text("Aba2")
                }
            
            Text("")
                .tabItem {
                    Image(systemName: "square.and.arrow.up")
                    Text("Aba3")
                }
        }
    }
}

#Preview {
    TutorialHomeView()
}
