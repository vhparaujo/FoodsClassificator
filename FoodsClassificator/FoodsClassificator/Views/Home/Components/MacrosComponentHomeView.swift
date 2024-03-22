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
    
    var body: some View {
        VStack {
            Text(macroType)
            Text("\(viewModel.macrosValue)")
                //.font(.system(size: 15))
                .foregroundStyle(.white)
                .font(.callout)
                .frame(width: 75, height: 35)
                .background(Color.myOrange)
                .clipShape(RoundedRectangle(cornerRadius: 17))
                
        }
    }
}

#Preview {
    MacrosComponentHomeView(macroType: "Teste")
}
