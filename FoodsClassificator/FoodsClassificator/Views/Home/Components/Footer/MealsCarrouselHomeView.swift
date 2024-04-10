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
    
    var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                ZStack{
                    ForEach(MealTime.allCases, id: \.self) { mealTime in
                        MealCircleComponentHomeView(mealText: mealTime.title) {
                            return AnyView(RecentMealsView(title: mealTime.title) { meal in
                                if var currentMeal = viewModel.totalMeals {
                                    currentMeal.totalCalories += meal.totalCalories
                                    currentMeal.macros.fats += meal.macros.fats
                                    currentMeal.macros.fibers += meal.macros.fibers
                                    currentMeal.macros.carbohydrates += meal.macros.carbohydrates
                                    currentMeal.macros.proteins += meal.macros.proteins
                                    
                                    // Atualiza a refeição atual com os novos valores
                                    viewModel.setTotalMeal(currentMeal)
                                    print("Refeição atualizada com o novo alimento: \(currentMeal)")
                                } else {
                                    // Cria uma nova refeição com os valores do alimento selecionado
                                    let newMeal = Meal(
                                        mealName: "Soma Refeições", // Assegure-se de que viewModel possui uma propriedade mealName
                                        image: "", // Use uma imagem padrão ou permita a seleção de uma imagem
                                        totalCalories: meal.totalCalories,
                                        macros: Macronutrients(fats: meal.macros.fats, fibers: meal.macros.fibers, carbohydrates: meal.macros.carbohydrates, proteins: meal.macros.proteins),
                                        foodDetails: [:] // Usa o dicionário criado
                                    )
                                    viewModel.setTotalMeal(newMeal)
                                    print("Nova refeição criada a partir do alimento selecionado: \(newMeal)")
                                }
                            })
                        }
                        .opacity(currentIndex == MealTime.allCases.firstIndex(of: mealTime) ? 1.0 : 0.5)
                        .scaleEffect(currentIndex == MealTime.allCases.firstIndex(of: mealTime) ? 1.0 : 0.5)
                        .offset(x: CGFloat(MealTime.allCases.firstIndex(of: mealTime)! - currentIndex) * 220 + dragOffset, y: 0)
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

//#Preview {
//    MealsCarrouselHomeView()
//}

