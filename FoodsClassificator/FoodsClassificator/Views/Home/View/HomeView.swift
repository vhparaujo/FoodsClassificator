//
//  HomeView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 20/03/24.
//

import SwiftUI

struct MyIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0.88529*height))
        path.addLine(to: CGPoint(x: 0.26803*width, y: 0.88529*height))
        path.addCurve(to: CGPoint(x: 0.30824*width, y: 0.90573*height), control1: CGPoint(x: 0.28327*width, y: 0.88529*height), control2: CGPoint(x: 0.29752*width, y: 0.8933*height))
        path.addCurve(to: CGPoint(x: 0.50513*width, y: height), control1: CGPoint(x: 0.35844*width, y: 0.96394*height), control2: CGPoint(x: 0.42811*width, y: height))
        path.addCurve(to: CGPoint(x: 0.70202*width, y: 0.90573*height), control1: CGPoint(x: 0.58215*width, y: height), control2: CGPoint(x: 0.65182*width, y: 0.96394*height))
        path.addCurve(to: CGPoint(x: 0.74223*width, y: 0.88529*height), control1: CGPoint(x: 0.71273*width, y: 0.8933*height), control2: CGPoint(x: 0.72699*width, y: 0.88529*height))
        path.addLine(to: CGPoint(x: width, y: 0.88529*height))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.closeSubpath()
        return path
    }
}

struct HomeView: View {
    
    var viewModel = HomeViewModel()
    var footerHomeViewModel = FooterHomeViewModel()
    
    var body: some View {
        
        VStack {
            HeaderView()
                .environment(viewModel)
            
            FooterView()
                .environment(footerHomeViewModel)
                .background(Image("backgroundHome"))
            
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
