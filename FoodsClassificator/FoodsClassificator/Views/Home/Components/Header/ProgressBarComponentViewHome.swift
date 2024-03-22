//
//  ProgressBarComponentViewHome.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 21/03/24.
//

import SwiftUI

struct ProgressBarComponentHomeView: View {
    
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        
        ZStack {
            Circle()
                .stroke(lineWidth: 23)
                .frame(width: 150, height: 136)
                .foregroundStyle(Color.white)
            
            Circle()
                .stroke(lineWidth: 19)
                .frame(width: 155, height: 136)
                .foregroundStyle(Color.laranjaMacros.opacity(0.5))
            
            Circle()
                .trim(from: 0.1, to: viewModel.progressBarValue)
                .stroke(style: StrokeStyle(lineWidth: 14, lineCap: .round))
                .frame(width: 155, height: 136)
                .rotationEffect(.degrees(-270))
                .foregroundStyle(.white)
   
        }
        
//        Gauge(value: 0, in: 0...1) {
//            
//        } currentValueLabel: {
//            
//        }
//        .gaugeStyle(.accessoryCircular)
        
    }
}

#Preview {
    ProgressBarComponentHomeView()
}
