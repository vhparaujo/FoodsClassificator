//
//  UserNameComponentPerfilView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftUI
import Combine

struct UserNameComponentPerfilView: View {
    
    @Binding var userName: String

    let textLimit = 12 //Your limit
    
    var body: some View {
        HStack(alignment: .center) {
            TextField("Digite seu nome", text: $userName)
                .font(.title)
                .foregroundStyle(.verdeTitle)
                .frame(width: 150)
                .clipShape(RoundedRectangle(cornerRadius: 1))
                .padding()
            
                .onReceive(Just(userName)) { _ in limitText(textLimit)
                }

        }
        
    }
    
    func limitText(_ textLimit: Int) {
        if userName.count > textLimit {
            userName = String(userName.prefix(textLimit))
        }
    }
    
}

#Preview {
    UserNameComponentPerfilView(userName: .constant("Fulano"))
}
