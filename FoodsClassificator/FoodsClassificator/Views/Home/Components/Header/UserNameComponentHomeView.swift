//
//  UserNameComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 21/03/24.
//

import SwiftUI

struct UserNameComponentHomeView: View {
    
    @Environment(\.modelContext) private var context
    
    @State var perfilViewModel = PerfilViewModel()
        
    var body: some View {
        VStack{
            
            if perfilViewModel.model.userName == "" {
                Text("Olá")
                    .font(.title)
                    .foregroundStyle(.verdeTitle)
            } else {
                Text("Olá, \(perfilViewModel.model.userName)!")
                    .font(.title)
                    .foregroundStyle(.verdeTitle)
            }
        }.onAppear(perform: {
            perfilViewModel.modelContext = context
        })
        
    }
    
}

//#Preview {
//   @Bindable var viewModel = PerfilViewModel()
//    return UserNameComponentHomeView(perfilViewModel: $viewModel.model.userName)
//        .environment(viewModel)
//}
