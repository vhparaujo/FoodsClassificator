//
//  DropDownComponentView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftUI

struct DropDownComponentView: View {
    
    @State private var isExpanded: Bool = false
    
    @State var alimento: String = ""
    @State var streak: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(alimento)
                        .font(.title)
                    Text("\(streak) \(PerfilTexts.dias)")
                        .font(.title3)
                }
                
                Spacer()
                
                Image("emoji1")
                    .resizable()
                    .frame(width: 70, height: 70)
            }
            
            if isExpanded {
                
                VStack {
                    
                    Text("Após o período de 21 dias, o cérebro começa a interpretar as mudanças como algo corriqueiro e incorporado à rotina")
                        .font(.callout)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Começar")
                            .foregroundStyle(.white)
                            .font(.callout)
                            .padding(12)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                    })
                }
                
            }
            
        }.padding()
            .background(Color.laranjaBrilhante)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .onTapGesture {
                withAnimation(.snappy) {
                    isExpanded.toggle()
                }
            }
            .padding(.horizontal)
        
    }
}
