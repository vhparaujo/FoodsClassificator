//
//  AddMealView.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 05/04/24.
//

import SwiftUI
import Vision

struct AddMealView: View {
    @StateObject var viewModel: AddMealViewModel = AddMealViewModel()
    @ObservedObject var speechRecognizerManager: SpeechRecognizerManager = SpeechRecognizerManager()
    @State var recentMealsViewModel: RecentMealsViewModel
    @State var sharingFoods: [VNRecognizedObjectObservation] = []
    
    var title: String
    var onCreateMeal: (Meal) -> Void
    
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    init(recentMealsViewModel: RecentMealsViewModel, title: String, onCreateMeal: @escaping (Meal) -> Void) {
        self.recentMealsViewModel = recentMealsViewModel
        self.title = title
        self.onCreateMeal = onCreateMeal
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                
                let cafe2 = Meal(mealName: "Cafe 2", image: "", totalCalories: 0, macros: Macronutrients(fats: 0, fibers: 0, carbohydrates: 0, proteins: 0), foodDetails: ["":FoodDetail(calories: 0, macros: Macronutrients(fats: 0, fibers: 0, carbohydrates: 0, proteins: 0))])
                
                VStack {
                    HeaderMealView(meal: recentMealsViewModel.currentMeal ?? cafe2, title: title, isExpanded: $viewModel.isExpanded)
                }
                .padding(.top, -screenHeight * 0.02)
                
                // Modal de sobreposição
                VStack {
                    RoundedRectangle(cornerRadius: 2.5)
                        .frame(width: screenWidth * 0.09, height: screenHeight * 0.006)
                        .padding(.top, screenHeight * 0.013)
                    
                    Picker("Selecione", selection: $viewModel.selectedSegment) {
                        Text("Usar Câmera").tag(0)
                        Text("Pesquisar Alimento").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: screenWidth * 0.9)
                    .padding(screenWidth * 0.02)
                    
                    if viewModel.selectedSegment == 0 {
                        UseCameraView(imagePredictor: ImagePredictor.shared,sharingFoods: $sharingFoods, selectedFoods: $viewModel.selectedFoods, selectFood: { code in
                            viewModel.addFoodCodesToSelect(foodCodes: code)
                            print("entrou closure: \(code)")
                        }, onScanMeal: { food in
                            print("Comida selecionada para adicionar à refeição: \(food)")
                            
                            // Função auxiliar para extrair e converter valores nutricionais
                            func valorParaComponente(_ componente: String) -> Double {
                                guard let detalhe = food.detalhesNutricionais.first(where: { $0.componente == componente }) else {
                                    print("Componente \(componente) não encontrado.")
                                    return 0.0
                                }
                                
                                guard let valor = Double(detalhe.valor) else {
                                    print("Não foi possível converter o valor do componente \(componente): \(detalhe.valor)")
                                    return 0.0
                                }
                                
                                return valor
                            }
                            
                            let fats = valorParaComponente("Lipídios")
                            let fibers = valorParaComponente("Fibra alimentar")
                            let carbohydrates = valorParaComponente("Carboidrato disponível")
                            let proteins = valorParaComponente("Proteína")
                            let totalCalories = Int(food.detalhesNutricionais.first { $0.componente == "Energia" && $0.unidade == "kcal" }?.valor.replacingOccurrences(of: ",", with: ".") ?? "0") ?? 0
                            
                            // Se já existe uma refeição atual, atualize seus valores
                            if var currentMeal = recentMealsViewModel.currentMeal {
                                currentMeal.totalCalories += totalCalories
                                currentMeal.macros.fats += fats
                                currentMeal.macros.fibers += fibers
                                currentMeal.macros.carbohydrates += carbohydrates
                                currentMeal.macros.proteins += proteins
                                // Atualiza a refeição atual com os novos valores
                                recentMealsViewModel.setCurrentMeal(currentMeal)
                                print("Refeição atualizada com o novo alimento: \(currentMeal)")
                            } else {
                                // Se não existe uma refeição atual, crie uma nova com os valores do alimento
                                let newMeal = Meal(
                                    mealName: "Refeição Personalizada",
                                    image: "", // Use uma imagem padrão ou permita a seleção de uma imagem
                                    totalCalories: totalCalories,
                                    macros: Macronutrients(fats: fats, fibers: fibers, carbohydrates: carbohydrates, proteins: proteins),
                                    foodDetails: [:] // Este campo pode ser preenchido conforme necessário
                                )
                                recentMealsViewModel.setCurrentMeal(newMeal)
                                print("Nova refeição criada a partir do alimento selecionado: \(newMeal)")
                            }
                        })
//                        .padding(.top, viewModel.isExpanded ? screenHeight * 0.05 : screenHeight * 0.15)
                    } else {
                        SearchFoodView(
                            searchText: $viewModel.searchText, 
                            speechRecognizerManager: speechRecognizerManager,
                            selectedFoods: $viewModel.selectedFoods,
                            filteredFoods: viewModel.filteredFoods
                        ) { food in
                            viewModel.addFoodToSelected(food: food)
                        } onAddMeal: { food in
                            print("Comida selecionada para adicionar à refeição: \(food)")
                            
                            // Função auxiliar para extrair e converter valores nutricionais
                            func valorParaComponente(_ componente: String) -> Double {
                                guard let detalhe = food.detalhesNutricionais.first(where: { $0.componente == componente }) else {
                                    print("Componente \(componente) não encontrado.")
                                    return 0.0
                                }
                                
                                guard let valor = Double(detalhe.valor) else {
                                    print("Não foi possível converter o valor do componente \(componente): \(detalhe.valor)")
                                    return 0.0
                                }
                                
                                return valor
                            }
                            
                            let fats = valorParaComponente("Lipídios")
                            let fibers = valorParaComponente("Fibra alimentar")
                            let carbohydrates = valorParaComponente("Carboidrato disponível")
                            let proteins = valorParaComponente("Proteína")
                            let totalCalories = Int(food.detalhesNutricionais.first { $0.componente == "Energia" && $0.unidade == "kcal" }?.valor.replacingOccurrences(of: ",", with: ".") ?? "0") ?? 0
                            
                            // Se já existe uma refeição atual, atualize seus valores
                            if var currentMeal = recentMealsViewModel.currentMeal {
                                currentMeal.totalCalories += totalCalories
                                currentMeal.macros.fats += fats
                                currentMeal.macros.fibers += fibers
                                currentMeal.macros.carbohydrates += carbohydrates
                                currentMeal.macros.proteins += proteins
                                // Atualiza a refeição atual com os novos valores
                                recentMealsViewModel.setCurrentMeal(currentMeal)
                                print("Refeição atualizada com o novo alimento: \(currentMeal)")
                            } else {
                                // Se não existe uma refeição atual, crie uma nova com os valores do alimento
                                let newMeal = Meal(
                                    mealName: "Refeição Personalizada",
                                    image: "", // Use uma imagem padrão ou permita a seleção de uma imagem
                                    totalCalories: totalCalories,
                                    macros: Macronutrients(fats: fats, fibers: fibers, carbohydrates: carbohydrates, proteins: proteins),
                                    foodDetails: [:] // Este campo pode ser preenchido conforme necessário
                                )
                                recentMealsViewModel.setCurrentMeal(newMeal)
                                print("Nova refeição criada a partir do alimento selecionado: \(newMeal)")
                            }
                        }
                        
                        if recentMealsViewModel.currentMeal != nil {
                            Button {
                                onCreateMeal(recentMealsViewModel.currentMeal!)
                            } label: {
                                Text("Criar refeição")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                            .frame(width: screenWidth * 0.56, height: screenHeight * 0.05)
                            .background(Color.verdeFundo)
                            .cornerRadius(28)
                            .padding(.bottom, screenHeight * 0.04)
                        }
                    }
                    
                    Spacer()
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
        .onAppear {
            self.speechRecognizerManager.requestPermission()
            
            Task {
                do {
                    try await viewModel.foodData.loadJson()
                } catch {
                    print(error.localizedDescription) // Trate o erro conforme necessário
                }
            }
        }
    }
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RecentMealsViewModel()
        viewModel.addMealToRecent(Meal(mealName: "Café da Manhã", image: "breakfast", totalCalories: 350, macros: Macronutrients(fats: 20, fibers: 20, carbohydrates: 20, proteins: 20), foodDetails: [:]))
        viewModel.setCurrentMeal(viewModel.recentMeals[0])
        
        return AddMealView(recentMealsViewModel: viewModel, title: "Café da Manhã", onCreateMeal: { _ in print("") })
    }
}

