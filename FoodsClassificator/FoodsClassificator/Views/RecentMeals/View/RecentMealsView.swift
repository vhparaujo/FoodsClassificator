//
//  RecentMeals.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 23/03/24.
//

import SwiftUI

struct RecentMealsView: View {
    @StateObject var viewModel: RecentMealsViewModel = RecentMealsViewModel()
    @State private var isExpanded = false
    @State private var haveCurrentMeal = false
    var title: String
    var onAddMeal: () -> Void

    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    
    init(title: String, onAddMeal: @escaping () -> Void) {
        self.title = title
        self.onAddMeal = onAddMeal
    }
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                
                let cafe2 = Meal(mealName: "Cafe 2", image: "", totalCalories: 0, macros: Macronutrients(fats: 0, fibers: 0, carbohydrates: 0, proteins: 0), foodDetails: ["":FoodDetail(calories: 0, macros: Macronutrients(fats: 0, fibers: 0, carbohydrates: 0, proteins: 0))])
                
                VStack {
                    HeaderMealView(meal: viewModel.currentMeal ?? cafe2, title: title, isExpanded: $isExpanded)
                }
                .padding(.top, -screenHeight * 0.02)
                
                // Modal de sobreposição
                VStack {
                    RoundedRectangle(cornerRadius: 2.5)
                        .frame(width: screenWidth * 0.09, height: screenHeight * 0.006)
                        .padding(.top, screenHeight * 0.013)
                    
                    Text("Refeições recentes")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    if viewModel.currentMeal == nil {
                        NavigationLink {
                            AddMealView(recentMealsViewModel: viewModel, title: self.title)
                        } label: {
                            HStack {
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.title3)
                                
                                Text("Nova refeição")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                            .frame(width: screenWidth * 0.94, height: screenHeight * 0.08)
                            .background(Color.laranjaFundoHome)
                            .cornerRadius(20)
                            .padding(.top, -screenWidth * 0.01)
                        }
                    }
                    
                    
                    if viewModel.recentMeals.isEmpty {
                        VStack {
                            Image("RecentMealsImage")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth * 0.38, height: screenHeight * 0.15)
                                .padding()
                            
                            Text("Adicione sua primeira refeição")
                                .foregroundColor(Color.laranjaMacros)
                                .font(.title3)
                                .padding()
                            
                            Spacer()
                        }
                        .padding(.top, isExpanded ? screenHeight * 0.05 : screenHeight * 0.1)
                    } else {
                        VStack {
                            ScrollView {
                                ForEach(viewModel.recentMeals) { meal in
                                    RecentMealCard(haveCurrentMeal: $haveCurrentMeal, meal: meal) {
                                        viewModel.setCurrentMeal(meal)
                                        self.haveCurrentMeal = true
                                    }
                                    .contextMenu {
                                        if haveCurrentMeal == false {
                                            Button(action: {
                                                viewModel.setCurrentMeal(meal)
                                                self.haveCurrentMeal = true
                                            }) {
                                                Label("Adicionar", systemImage: "plus.circle")
                                            }
                                        }
                                        Button(action: {
                                            viewModel.editMeal(meal.id, with: meal)
                                        }) {
                                            Label("Editar", systemImage: "pencil")
                                        }
                                        
                                        Button(action: {
                                            viewModel.deleteMeal(meal.id)
                                        }) {
                                            Label("Deletar", systemImage: "trash")
                                        }
                                    }
                                    .padding()
                                }
                            }
                        }
                    }
                    
                    if viewModel.currentMeal != nil {
                        Button(action: onAddMeal) {
                            Text("Adicionar refeição")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        .frame(width: screenWidth * 0.56, height: screenHeight * 0.05)
                        .background(Color.laranjaFundoHome)
                        .cornerRadius(28)
                        .padding(.bottom, screenHeight * 0.04)
                    }
                    
                }
                .frame(width: screenWidth, height: isExpanded ? screenHeight * 0.56 : screenHeight * 0.78)
                .fixedSize(horizontal: false, vertical: true)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous).path(in: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)))
                .animation(.spring(), value: isExpanded)
                .gesture(
                    DragGesture().onEnded { value in
                        if value.translation.height > 50 {
                            withAnimation {
                                isExpanded = true
                            }
                        } else if value.translation.height < -50 {
                            withAnimation {
                                isExpanded = false
                            }
                        }
                    }
                )
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            if viewModel.recentMeals.isEmpty {
                let cafe1 = Meal(mealName: "Cafe 1", image: "", totalCalories: 400, macros: Macronutrients(fats: 21, fibers: 7, carbohydrates: 50, proteins: 30), foodDetails: ["arroz":FoodDetail(calories: 400, macros: Macronutrients(fats: 21, fibers: 7, carbohydrates: 50, proteins: 30))])
                viewModel.addMealToRecent(cafe1)
            }
        }
    }
}

struct RecentMealsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RecentMealsViewModel()
        viewModel.addMealToRecent(Meal(mealName: "Café da Manhã", image: "breakfast", totalCalories: 350, macros: Macronutrients(fats: 20, fibers: 20, carbohydrates: 20, proteins: 20), foodDetails: [:]))
        viewModel.setCurrentMeal(viewModel.recentMeals[0])
        
        return RecentMealsView(title: "Café da Manhã", onAddMeal: {
            // Aqui você implementa a ação de adicionar uma nova refeição.
            // Para propósitos de preview, isso pode ficar vazio ou apenas imprimir uma mensagem.
            print("Adicionar nova refeição")
        })
    }
}

