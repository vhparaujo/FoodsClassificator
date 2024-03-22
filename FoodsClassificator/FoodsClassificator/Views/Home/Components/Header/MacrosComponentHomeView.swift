//
//  MacrosComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 20/03/24.
//

import SwiftUI

struct MacrosComponentHomeView: View {
    
    @State private var viewModel = HomeViewModel()
    
    @State var macroType: String = ""
    @State var backgroundColor: Color = .clear
    
    var body: some View {
        VStack {
            Text(macroType)
                .font(.subheadline)
                .foregroundStyle(.white)
            Text("\(viewModel.macrosValue)")
                //.font(.system(size: 15))
                .foregroundStyle(.black)
                .font(.callout)
                .frame(width: 75, height: 35)
                .background(backgroundColor)
                .overlay (
                    RoundedRectangle(cornerRadius: 17)
                        .stroke(Color.white, lineWidth: 3.5)
                )
                .clipShape(RoundedRectangle(cornerRadius: 17))
                
        }
    }
}

#Preview {
    MacrosComponentHomeView(macroType: "Teste")
}
