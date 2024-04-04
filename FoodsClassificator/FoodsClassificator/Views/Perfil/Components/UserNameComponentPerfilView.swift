//
//  UserNameComponentPerfilView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftUI

struct UserNameComponentPerfilView: View {
    
    @State var userName: String = ""
    
    var body: some View {
        Text(userName)
            .font(.title)
            .foregroundStyle(.white)
    }
}

#Preview {
    UserNameComponentPerfilView()
}
