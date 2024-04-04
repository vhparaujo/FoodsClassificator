//
//  MealsCarrouselHomeView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 21/03/24.
//

import SwiftUI

struct MealsCarrouselHomeView: View {
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    let firstUseTips = FirstUseTips()
    
    private let mealViews: [(String, () -> Void)] = [
        ("Café da manhã", { print("Alimento adicionado ao Café da manhã") }),
        ("Almoço", { print("Alimento adicionado ao Almoço") }),
        ("Lanche", { print("Alimento adicionado ao Lanche") }),
        ("Ceia", { print("Alimento adicionado à Ceia") }),
        ("Jantar", { print("Alimento adicionado ao Jantar") })
    ]
    
    var body: some View {
        NavigationStack{
            VStack{
                ZStack{
                    ForEach(0..<mealViews.count, id: \.self) { index in
                        MealCircleComponentHomeView(mealText: mealViews[index].0,
                                                    buttonAction: mealViews[index].1)
                        .frame(width: 300, height: 300)
                        .opacity(currentIndex == index ? 1.0 : 0.5)
                        .scaleEffect(currentIndex == index ? 1.0 : 0.5)
                        .offset(x: CGFloat(index - currentIndex) * 220 + dragOffset , y: 0)
                        
                    }
                }
                .gesture(
                    DragGesture()
                        .onEnded({ value in
                            let threshhold: CGFloat = 50
                            if value.translation.width > threshhold {
                                withAnimation {
                                    currentIndex = max(0, currentIndex - 1)
                                }
                            } else if value.translation.width < -threshhold{
                                withAnimation {
                                    currentIndex = min(mealViews.count - 1,
                                                       currentIndex + 1)
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
