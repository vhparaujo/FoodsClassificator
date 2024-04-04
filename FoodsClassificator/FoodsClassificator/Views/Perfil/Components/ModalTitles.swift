//
//  ModalTitles.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftUI

struct ModalTitles: View {
    
    @State var title: String = ""
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .bold()
            Spacer()
        }.padding(.horizontal)
    }
}

#Preview {
    ModalTitles()
}
