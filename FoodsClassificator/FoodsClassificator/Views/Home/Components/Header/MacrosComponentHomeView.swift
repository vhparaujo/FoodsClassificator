//
//  MacrosComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 20/03/24.
//

import SwiftUI

struct MacrosComponentHomeView: View {
    
    @Environment(HomeViewModel.self) var viewModel: HomeViewModel

    @State var macroType: String = ""
    @State var backgroundColor: Color = .clear
    
    var body: some View {
        VStack {
            Text(macroType)
                .font(.footnote)
                .foregroundStyle(.verdeTitle)
                .lineLimit(1)
                
            Text("\(viewModel.macrosValue)")
                .foregroundStyle(.black)
                .font(.subheadline)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .padding(.horizontal, 25)
                .padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 17, style: .continuous).foregroundStyle(backgroundColor))
                .overlay (
                    RoundedRectangle(cornerRadius: 17)
                        .stroke(Color.white, lineWidth: 2)
                )
                
               
        }
    }
}

#Preview {
    var viewModel = HomeViewModel()
    return MacrosComponentHomeView(macroType: "Carboidrafhjufehuejfujcutos", backgroundColor: .blue)
        .environment(viewModel)
}
