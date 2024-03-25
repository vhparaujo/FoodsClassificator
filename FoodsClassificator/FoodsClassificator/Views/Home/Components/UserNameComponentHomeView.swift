//
//  UserNameComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 21/03/24.
//

import SwiftUI

struct UserNameComponentHomeView: View {
    
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        Text(viewModel.userName)
            .font(.title)
    }
}

#Preview {
    UserNameComponentHomeView()
}
