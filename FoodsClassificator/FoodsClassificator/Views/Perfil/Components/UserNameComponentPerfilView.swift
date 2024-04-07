//
//  UserNameComponentPerfilView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftUI

struct UserNameComponentPerfilView: View {
    
    @Binding var userName: String
    
    var body: some View {
        HStack(alignment: .center) {
            TextField("Digite seu nome", text: $userName)
                .font(.title)
                .foregroundStyle(.verdeTitle)
                .clipShape(RoundedRectangle(cornerRadius: 1))
                .padding()
        }
        
    }
    
}

#Preview {
    UserNameComponentPerfilView(userName: .constant("Fulano"))
}
