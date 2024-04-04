//
//  Tutorial.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 03/04/24.
//

import SwiftUI

struct ImageTutorial: View {
    @State private var showAlert = false
    @State private var tabIndex = 0
    private let totalImages = 5
    @State private var navigateTo: String? = nil
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationStack {
                TabView(selection: $tabIndex) {
                    ForEach(0..<totalImages, id: \.self) { index in
                        Image("tutorial\(index + 1)")
                            .resizable()
                            .scaledToFill()
//                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .tag(index)
                            .onTapGesture {
                                if index == totalImages - 1 {
                                    showAlert = true
                                } else {
                                    withAnimation {
                                        tabIndex = index + 1
                                    }
                                }
                            }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .alert("Definir calorias", isPresented: $showAlert) {
                    Button("Melhorar a Experiência", role: .destructive) {
                        navigateTo = "melhorarExperiencia"
                    }
                    Button("Talvez mais tarde", role: .cancel) {
                        navigateTo = "talvezMaisTarde"
                    }
                } message: {
                    Text("Precisamos de algumas informações para melhorar sua experiência definindo as calorias, levará 5 minutos.")
                }
                NavigationLink(destination: Text("Página Melhorar Experiência"), tag: "melhorarExperiencia", selection: $navigateTo) { EmptyView() }
                NavigationLink(destination: Text("Página Talvez Mais Tarde"), tag: "talvezMaisTarde", selection: $navigateTo) { EmptyView() }
            }
        }
        
        // Navegação condicional invisível
        
    }
}





#Preview {
    ImageTutorial()
}
