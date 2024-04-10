//
//  EditMealView.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 09/04/24.
//

import SwiftUI

struct EditMealView: View {
    @ObservedObject var viewModel: EditMealViewModel
    @State private var expandedFoodName: String? = nil
    @State private var foodWeights: [String: Int] = [:]
    
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    var onMealUpdated: () -> Void
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack {
                    HeaderMealView(meal: viewModel.meal, title: "Editar Refeição", isExpanded: $viewModel.isExpanded)
                }
                .padding(.top, -screenHeight * 0.02)
                
                VStack {
                    RoundedRectangle(cornerRadius: 2.5)
                        .frame(width: screenWidth * 0.09, height: screenHeight * 0.006)
                        .padding(.top, screenHeight * 0.013)
                    
                    // Lista de alimentos selecionados
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(Array(viewModel.foodDetails.keys.enumerated()), id: \.element) { index, foodName in
                                let foodDetail = viewModel.foodDetails[foodName]!
                                let energyKcal = "\(foodDetail.calories) Cal"
                                
                                if viewModel.isExpanded && expandedFoodName == foodName {
//                                    ExpandedFoodDetailView(
//                                        showImage: false, // Ajuste conforme necessário
//                                        food: Food(codigo: "", nome: foodName, grupo: "", marca: "", detalhesNutricionais: []),
//                                        onSave: { updatedFood, updatedWeight in
//                                            // Aqui, você atualiza os detalhes do alimento com base na edição.
//                                            self.viewModel.addOrUpdateFoodDetail(
//                                                name: updatedFood.nome,
//                                                detail: FoodDetail(calories: updatedFood.detalhesNutricionais.first { $0.componente == "Energia" && $0.unidade == "kcal" }?.valor ?? "0",
//                                                                   macros: foodDetail.macros)
//                                            )
//                                            self.foodWeights[updatedFood.nome] = updatedWeight
//                                            self.expandedFoodName = nil
//                                        }
//                                    )
//                                    .transition(.slide)
                                } else {
                                    Button {
                                        expandedFoodName = foodName
                                    } label: {
                                        FoodItemCell(
                                            showImage: true,
                                            title: foodName,
                                            weight: "\(foodWeights[foodName, default: 100]) gramas",
                                            calories: energyKcal, onAdd: {
                                                print("aadd")
                                            }
                                        )
                                    }
                                    .transition(.slide)
                                }
                            }
                        }
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(20)
                        .padding()
                        
                        Spacer()
                        
                        Button("Salvar Alterações") {
                            // Aqui, você invocaria algum método do viewModel para salvar as alterações na refeição
                            onMealUpdated()
                        }
                        .frame(width: screenWidth * 0.56, height: screenHeight * 0.05)
                        .background(Color.verdeFundo)
                        .cornerRadius(28)
                        .padding(.bottom, screenHeight * 0.04)
                    }
                }
                .frame(width: screenWidth, height: viewModel.isExpanded ? screenHeight * 0.56 : screenHeight * 0.78)
                .fixedSize(horizontal: false, vertical: true)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous).path(in: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)))
                .animation(.spring(), value: viewModel.isExpanded)
                .gesture(
                    DragGesture().onEnded { value in
                        if value.translation.height > 50 {
                            withAnimation {
                                viewModel.isExpanded = true
                            }
                        } else if value.translation.height < -50 {
                            withAnimation {
                                viewModel.isExpanded = false
                            }
                        }
                    }
                )
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Implementação de PreviewProvider se necessário
    struct EditMealView_Previews: PreviewProvider {
        static var previews: some View {
            // Criação de dados de amostra para a pré-visualização
            let sampleMeal = Meal(
                mealName: "Almoço de Teste",
                image: "sampleImage", // Substitua por uma imagem válida ou remova se não estiver usando
                totalCalories: 600,
                macros: Macronutrients(fats: 20, fibers: 10, carbohydrates: 70, proteins: 30),
                foodDetails: [
                    "Maçã": FoodDetail(calories: 52, macros: Macronutrients(fats: 0.2, fibers: 2.4, carbohydrates: 14, proteins: 0.3)),
                    "Arroz": FoodDetail(calories: 130, macros: Macronutrients(fats: 0.3, fibers: 1.8, carbohydrates: 28, proteins: 2.7))
                ]
            )

            // Instância do ViewModel configurada com dados de amostra
            let viewModel = EditMealViewModel(meal: sampleMeal)

            // Renderização da EditMealView com o ViewModel de amostra
            EditMealView(viewModel: viewModel) {
                // Aqui você pode definir o que acontece quando o botão "Salvar Alterações" é pressionado
                // Para a pré-visualização, pode ser apenas uma impressão no console
                print("Alterações salvas")
            }
        }
    }
