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
                .foregroundStyle(Color.laranjaFundoHome)
                .frame(width: 300, height: 100)
            .padding()
            
            VStack {
                HStack {
                    Text("Água")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundStyle(Color.white)
                        .padding(.horizontal)

                    Spacer()
                    
                    Text("0/2L")
                        .font(.system(size: 20))
                        .bold()                    .foregroundStyle(Color.white)

                    Button(action: {
                        print("EDITAR")
                    }, label: {
                        Image(systemName: "pencil")
                            .font(.title)
                            .foregroundStyle(Color.white)
                            .padding(.horizontal)
                    })
                }
                .padding(.horizontal, 50)
                
                HStack{
                    Button(action: {
                        print("Agua foi adicionada")
                    }, label: {
                        Image("waterbottle")
                            .resizable().frame(width: 20, height: 50)
                    })
                    .padding(.horizontal)

                    Button(action: {
                        print("Agua foi adicionada")
                    }, label: {
                        Image("waterbottle")
                            .resizable().frame(width: 20, height: 50)

                    })
                    .padding(.horizontal)

                    Button(action: {
                        print("Agua foi adicionada")
                    }, label: {
                        Image("waterbottle")
                            .resizable().frame(width: 20, height: 50)

                    })
                    .padding(.horizontal)

                    Button(action: {
                        print("Agua foi adicionada")
                    }, label: {
                        Image("waterbottle")
                            .resizable().frame(width: 20, height: 50)

                    })
                    .padding(.horizontal)
                    
                }
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
