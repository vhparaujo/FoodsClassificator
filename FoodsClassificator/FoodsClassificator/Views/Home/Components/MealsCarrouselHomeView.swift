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
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var selectedMealTime: MealTime?
    
    var body: some View {
        NavigationStack{
            VStack{
                ZStack{
                    ForEach(MealTime.allCases.indices, id: \.self) { index in
                        let meal = MealTime.allCases[index]
                        
                        MealCircleComponentHomeView(mealText: meal.title) {
                            return AnyView(RecentMealsView(title: meal.title) {
                                print("Chamando view 'Add Meal' para \(meal.title)")
                            })
                        }
                        .frame(width: 300, height: 300)
                        .opacity(currentIndex == index ? 1.0 : 0.5)
                        .scaleEffect(currentIndex == index ? 1.0 : 0.5)
                        .offset(x: CGFloat(index - currentIndex) * 220 + dragOffset, y: 0)
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
        }
    }
}

#Preview {
    MealsCarrouselHomeView()
}
