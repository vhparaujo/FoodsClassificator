//
//  WaterRectangleComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 22/03/24.
//

import SwiftUI

struct WaterRectangleComponentHomeView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(Color.laranjaMacros)
                .frame(width: .infinity, height: 150)
            .padding()
            
            VStack {
                HStack {
                    Text("Água")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(Color.white)
                        .padding(.horizontal)

                    Spacer()
                    
                    Text("0/2L")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(Color.white)

                    Button(action: {
                        print("EDITAR")
                    }, label: {
                        Image(systemName: "pencil")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(Color.white)
                            .padding(.horizontal)
                    })
                }
                
                HStack{
                    Button(action: {
                        print("Agua foi adicionada")
                    }, label: {
                        Image("waterbottle")
                    })
                    .padding(.horizontal)

                    Button(action: {
                        print("Agua foi adicionada")
                    }, label: {
                        Image("waterbottle")
                    })
                    .padding(.horizontal)

                    Button(action: {
                        print("Agua foi adicionada")
                    }, label: {
                        Image("waterbottle")
                    })
                    .padding(.horizontal)

                    Button(action: {
                        print("Agua foi adicionada")
                    }, label: {
                        Image("waterbottle")
                    })
                    .padding(.horizontal)
                    
                }
            }
            .padding()
        }
    }
}

#Preview {
    WaterRectangleComponentHomeView()
}
