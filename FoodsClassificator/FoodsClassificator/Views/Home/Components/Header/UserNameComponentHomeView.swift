//
//  UserNameComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 21/03/24.
//

import SwiftUI

struct UserNameComponentHomeView: View {
    
    @Environment(HomeViewModel.self) var viewModel: HomeViewModel
    
    var body: some View {
        Text(viewModel.userName)
            .font(.title)
            .foregroundStyle(.white)
    }
}

#Preview {
    var viewModel = HomeViewModel()
    return UserNameComponentHomeView()
        .environment(viewModel)
}
