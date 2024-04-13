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
        
        VStack {
            TextField("Digite seu nome", text: $userName)
                .font(.title)
                .foregroundStyle(.verdeTitle)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
            
                .onReceive(Just(userName)) { _ in
                    limitText(textLimit)
                }
            
            HStack {
                Spacer()
                Text("\(userName.count)/\(textLimit)")
                    .font(.callout)
                    .foregroundStyle(.verdeTitle)
                    .padding(.horizontal)
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
