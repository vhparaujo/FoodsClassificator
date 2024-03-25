//
//  RecentMeals.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 23/03/24.
//

import SwiftUI

struct RecentMealsView: View {
    @State private var isExpanded = false
    @ObservedObject var viewModel: RecentMealsViewModel
    var title: String
    var onAddMeal: () -> Void 
    
    init(title: String, viewModel: RecentMealsViewModel, onAddMeal: @escaping () -> Void) {
        self.title = title
        self.viewModel = viewModel
        self.onAddMeal = onAddMeal
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                // Seu conteúdo principal aqui...
                let cafe1 = Meal(mealName: "Cafe 1", image: "", totalCalories: 400, macros: Macronutrients(fats: 21, fibers: 7, carbohydrates: 50, proteins: 30), foodDetails: ["arroz":FoodDetail(calories: 400, macros: Macronutrients(fats: 21, fibers: 7, carbohydrates: 50, proteins: 30))])
                
                VStack {
                    HeaderMealView(meal: viewModel.currentMeal ?? cafe1, title: title, isExpanded: $isExpanded)
                }
                
                // Modal de sobreposição
                VStack {
                    RoundedRectangle(cornerRadius: 2.5)
                        .frame(width: geometry.size.width * 0.09, height: geometry.size.height * 0.006)
                        .padding(.top, geometry.size.height * 0.013)
                    
                    Text("Refeições recentes")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .center)
//                        .padding()
                    
                    Button("Adicionar nova refeição") {
                        onAddMeal()
                    }
                    
                    .buttonStyle(.borderedProminent)
                    
                    VStack {
                        ScrollView {
                            ForEach(viewModel.recentMeals) { meal in
                                RecentMealCard(meal: meal) {
                                    viewModel.setCurrentMeal(meal)
                                }
                                .padding()
                            }
                        }
                    }
                }
                .frame(width: geometry.size.width)
                .background(Color.white)
                .cornerRadius(30)
                .frame(height: isExpanded ? geometry.size.height * 0.72 : geometry.size.height * 0.9)
                .animation(.spring(), value: isExpanded)
                .gesture(
                    DragGesture().onEnded { value in
                        if value.translation.height > 50 { // Arraste para baixo
                            withAnimation {
                                isExpanded = true
                            }
                        } else if value.translation.height < -50 { // Arraste para cima
                            withAnimation {
                                isExpanded = false
                            }
                        }
                    }
                )
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct RecentMealsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RecentMealsViewModel()
        viewModel.addMealToRecent(Meal(mealName: "Café da Manhã", image: "breakfast", totalCalories: 350, macros: Macronutrients(fats: 20, fibers: 20, carbohydrates: 20, proteins: 20), foodDetails: [:]))
        viewModel.setCurrentMeal(viewModel.recentMeals[0])
        
        return RecentMealsView(title: "Café da Manhã", viewModel: viewModel, onAddMeal: {
            // Aqui você implementa a ação de adicionar uma nova refeição.
            // Para propósitos de preview, isso pode ficar vazio ou apenas imprimir uma mensagem.
            print("Adicionar nova refeição")
        })
    }
}

