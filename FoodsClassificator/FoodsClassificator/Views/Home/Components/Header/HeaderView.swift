//
//  HeaderView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 21/03/24.
//

import SwiftUI

struct HeaderView: View {

    var body: some View {
        VStack {
            
            HStack {
                UserNameComponentHomeView()
                Spacer()
                UserPhotoAndStreakComponentHomeView()
            }.padding(.horizontal)
            
            HStack {
                ZStack {
                    HStack{
                        VStack {
                            MacrosComponentHomeView(macroType: "Fibras", backgroundColor: Color.amareloFibras)
                                .padding(.vertical)
                            
                            MacrosComponentHomeView(macroType: "Gorduras", backgroundColor: Color.rosaGorduras)
                                .padding(.vertical)
                        }
                        
                        Spacer()
                        
                        VStack {
                            MacrosComponentHomeView(macroType: "Proteínas", backgroundColor: Color.rosaProteinas)
                                .padding(.vertical)
                            
                            MacrosComponentHomeView(macroType: "Carboidratos", backgroundColor: Color.verdeCarboidratos)
                                .padding(.vertical)
                        }
                    }
                    
                    ProgressBarComponentHomeView()
                        .offset(y: 50)
                }
            }
            .padding(.bottom)
            .padding(.horizontal)
            
            

        }.background(Color.laranjaFundoHome)

    }
}

#Preview {
    HeaderView()
}
