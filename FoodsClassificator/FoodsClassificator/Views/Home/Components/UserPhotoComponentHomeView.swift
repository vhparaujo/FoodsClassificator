//
//  UserPhotoComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 21/03/24.
//

import SwiftUI

struct UserPhotoComponentHomeView: View {
    
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        Circle()
            .overlay {
                Image(viewModel.userPhoto)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
            }
            .frame(width: 45, height: 45)
    }
}

#Preview {
    UserPhotoComponentHomeView()
}
