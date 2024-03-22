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
                VStack {
                    MacrosComponentHomeView(macroType: "Fibras", backgroundColor: Color.amareloFibras)
                    
                    MacrosComponentHomeView(macroType: "Gorduras", backgroundColor: Color.rosaGorduras)
                }
                
                Spacer()
                
                ProgressBarComponentHomeView()
                    .offset(y: 50)
                
                Spacer()
                
                VStack {
                    MacrosComponentHomeView(macroType: "Proteínas", backgroundColor: Color.rosaProteinas)
                    
                    MacrosComponentHomeView(macroType: "Carboibratos", backgroundColor: Color.verdeCarboidratos)
                }
                
            }.padding(.bottom)
                .padding(.horizontal)

        }.background(Color.laranjaFundoHome)

    }
}

#Preview {
    HeaderView()
}
