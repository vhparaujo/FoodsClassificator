//
//  ListPerfilComponentView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftUI

struct ListPerfilComponentView<T>: View {
    
    @State var label: String = ""
    @State var data: T

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text("\(data)")
                .foregroundStyle(.secondary)
        }
        
    }
}

#Preview {
    ListPerfilComponentView(label: "Idade", data: 21)
}
