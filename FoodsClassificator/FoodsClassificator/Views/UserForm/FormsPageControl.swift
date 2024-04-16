//
//  FormsPageControl.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 15/04/24.
//

import SwiftUI
import SwiftData

struct FormsPageControl: View {
    var body: some View {
        
        VStack {
            FormProgressBar(progress: 0.15)
            TabView{
                FormsPage1()
                FormsPage2()
                FormsPage3()
                FormsPage4()
                FormsPage5()
                FormsPage6()
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .never))
        }
    }
}

#Preview {
    let modelContainer: ModelContainer = .appContainer
    return FormsPageControl().modelContainer(modelContainer)
}

