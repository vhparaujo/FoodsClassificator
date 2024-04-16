//
//  teste.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 16/04/24.
//


import SwiftUI

// ViewModel para gerenciar o progresso
class ProgressViewModel: ObservableObject {
    @Published var progress: Double = 0.0
}

// ProgressBar customizada
struct ProgressBarTeste: View {
    var progress: Double
    
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .frame(width: geometry.size.width * CGFloat(progress), height: 10)
                .foregroundColor(.blue)
                .animation(.linear, value: progress)
                .border(Color.gray, width: 1)
        }
    }
}

// Tela base com NavigationView
struct BaseView: View {
    @StateObject var viewModel = ProgressViewModel()

    var body: some View {
        NavigationView {
            VStack {
                ProgressBarTeste(progress: viewModel.progress)
                NavigationLink("Go to Next Screen", destination: SecondView(viewModel: viewModel))
            }
            .navigationBarHidden(true)
        }
    }
}

// Segunda tela
struct SecondView: View {
    @ObservedObject var viewModel: ProgressViewModel

    var body: some View {
        VStack {
            ProgressBarTeste(progress: viewModel.progress)
            Button("Increase Progress") {
                if viewModel.progress < 1.0 {
                    viewModel.progress += 0.2
                }
            }
        }
    }
}

struct ProgressBarTesteView: View {
    var body: some View {
        BaseView()
    }
}
