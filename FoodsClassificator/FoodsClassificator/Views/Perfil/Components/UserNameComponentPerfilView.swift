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
        TextField("Olá", text: $userName)
            .font(.title)
            .foregroundStyle(.verdeTitle)
    }
    
}

#Preview {
    UserNameComponentPerfilView(userName: .constant("Fulano"))
}
