//
//  UseCameraView.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 05/04/24.
//

import SwiftUI
import Vision

struct UseCameraView: View {
    
    @ObservedObject var imagePredictor: ImagePredictor
    @State private var isShowingCamera = false
    @Binding var sharingFoods:[VNRecognizedObjectObservation]
    @Binding var selectedFoods: [Food]
    @State private var foodWeights: [String: Int] = [:]
    

    var selectFood: ([String]) -> Void
    var onScanMeal: (Food) -> Void
    
    @State private var expandedFood: Food?
    @State private var isExpanded: Bool = false
    @State private var expandedFoodCode: String?

    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height


    
    var body: some View {
        VStack {
            
            ZStack(alignment: .top) {
                if !selectedFoods.isEmpty {
                    // Lista de alimentos selecionados
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(selectedFoods.indices, id: \.self) { index in
                                let food = selectedFoods[index]
                                let energiaKcal = food.detalhesNutricionais.first(where: {$0.componente == "Energia" && $0.unidade == "kcal"})?.valor ?? "0"
                                let energiaKcalText = "\(energiaKcal) Cal"
                                
                                
                                // Aqui, ao invés de passar valores fixos, usaremos os dados reais do alimento
                                if isExpanded && expandedFoodCode == food.codigo {
                                    let _ = print("Exibindo ExpandedFoodDetailView para: \(food.nome)")
                                    // O ExpandedFoodDetailView é apresentado com os dados do alimento selecionado
                                    ExpandedFoodDetailView(showImage: false, food: food, onSave: { updatedFood, updatedWeight in
                                        print("Salvando alterações para: \(updatedFood.nome)")
                                        withAnimation {
                                            if let index = selectedFoods.firstIndex(where: { $0.codigo == updatedFood.codigo }) {
                                                selectedFoods[index] = updatedFood
                                                foodWeights[updatedFood.codigo] = updatedWeight // Atualiza o peso no dicionário
                                                isExpanded = false
                                                expandedFoodCode = nil
                                            }
                                        }
                                    })
                                    .transition(.slide)
                                } else {
                                    Button {
                                        print("Tentativa de expandir o item: \(food.nome)")
                                        withAnimation {
                                            if expandedFoodCode == food.codigo {
                                                expandedFoodCode = nil // Recolhe se já está expandido
                                            } else {
                                                expandedFoodCode = food.codigo // Expande o novo item
                                            }
                                            expandedFood = food
                                            isExpanded = true
                                            print("isExpanded agora é \(isExpanded) para \(food.nome)")
                                        }
                                    } label: {
                                        let weightText = "\(foodWeights[food.codigo, default: 100]) gramas"
                                        
                                        FoodItemCell(showImage: true, title: food.nome, weight: weightText, calories: energiaKcalText) {
                                            onScanMeal(food)
                                        }
                                        .transition(.slide)
                                    }
                                }
                            }
                        }
                    }
                    .background(Color.white.opacity(0.6))
                    .cornerRadius(20)
                    .padding(.top, screenHeight * 0.02)
                    
                } else {
                    VStack {
                        Spacer()
                        Image("AddMealImage")
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
//                    .padding(.top, -screenWidth * 0.12)
                }
                
            }
            
            Spacer()
            
            Button() {
                isShowingCamera.toggle()
            }label:{
                HStack {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .bold()
                        .font(.title3)
                    
                    Text("Escanear")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .frame(width: screenWidth * 0.4, height: screenHeight * 0.05)
            .background(Color.laranjaMacros)
            .cornerRadius(28)
            .padding(.bottom, screenHeight * 0.04) 
        }
        .fullScreenCover(isPresented: $isShowingCamera) {
            // Corrigindo aqui para passar os dados capturados corretamente para selectFood
            CameraView(onDismiss: { capturedData in
                selectFood(capturedData)
            })
        }
    }
    

}


