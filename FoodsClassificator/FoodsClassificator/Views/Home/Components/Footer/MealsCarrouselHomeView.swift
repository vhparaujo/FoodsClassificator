//
//  MealsCarrouselHomeView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 21/03/24.
//

import SwiftUI

// Define um enum para as refeições, incluindo um título e um identificador único para cada uma.
enum MealTime: String, CaseIterable {
    case breakfast = "Café da manhã"
    case lunch = "Almoço"
    case snack = "Lanche"
    case supper = "Ceia"
    case dinner = "Jantar"
    
    // Método para retornar um título para a view.
    var title: String {
        return self.rawValue
    }
}

struct MealsCarrouselHomeView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var selectedMealTime: MealTime?
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        NavigationStack{
            VStack{
                ZStack{
                    ForEach(0..<mealViews.count, id: \.self) { index in
                        MealCircleComponentHomeView(mealText: mealViews[index].0,
                                                    buttonAction: mealViews[index].1)
//                        .frame(width: 300, height: 300)
                        .opacity(currentIndex == index ? 1.0 : 0.5)
                        .scaleEffect(currentIndex == index ? 1.0 : 0.5)
                        .offset(x: CGFloat(index - currentIndex) * 240 + dragOffset , y: 0)
                        
                    }
                }
                
                
                .gesture(
                    DragGesture()
                        .onEnded({ value in
                            let threshold: CGFloat = 50
                            if value.translation.width > threshold {
                                withAnimation {
                                    currentIndex = max(0, currentIndex - 1)
                                }
                            } else if value.translation.width < -threshold {
                                withAnimation {
                                    currentIndex = min(MealTime.allCases.count - 1, currentIndex + 1)
                                }
                            }
                        })
                )
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
