//
//  SearchFoodView.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 05/04/24.
//

import SwiftUI

struct SearchFoodView: View {
    @Binding var searchText: String
    @ObservedObject var speechRecognizerManager: SpeechRecognizerManager
    @Binding var selectedFoods: [Food]
    var filteredFoods: [Food]
    var selectFood: (Food) -> Void
    var onAddMeal: (Food) -> Void
    
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        VStack {
            HStack {
                TextField("Buscar alimentos...", text: $searchText)
                    .padding()
                    .frame(height: screenHeight * 0.04)
                    .padding(.leading, 30)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(12)
                    .overlay(
                        HStack {
                            // Ícone de lupa à esquerda
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.leading, 10)
                            
                            Spacer()
                            
                            // Ícone de microfone à direita
                            Button(action: {
                                if self.speechRecognizerManager.isListening {
                                    print("Parando o reconhecimento de voz...")
                                    self.speechRecognizerManager.stopListening()
                                } else {
                                    print("Iniciando o reconhecimento de voz...")
                                    self.speechRecognizerManager.startListening()
                                }
                            }) {
                                Image(systemName: speechRecognizerManager.isListening ? "mic.fill" : "mic.slash.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        }
                )
                
                // Botão de cancelar que aparece quando searchText não está vazio
                if !searchText.isEmpty {
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Text("Cancelar")
                            .lineLimit(1)
                    }
                    .foregroundStyle(.blue)
                    .padding(.horizontal, screenWidth * 0.02)
                }
            }
            .padding(.horizontal)
            .padding(.top, -screenHeight * 0.01)
            
            
            ZStack(alignment: .top) {
                if !selectedFoods.isEmpty {
                    // Lista de alimentos selecionados
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(selectedFoods) { food in
                                let energiaKcal = food.detalhesNutricionais.first { $0.componente == "Energia" && $0.unidade == "kcal" }
                                let energiaKcalText = energiaKcal.map { "\($0.valor) Cal" } ?? "N/A"
                                
                                // Buscar o detalhe de peso, se disponível
                                let pesoText = "100 gramas" // Isso pode ser ajustado dependendo do seu modelo
                                
                                // Agora você pode usar `energiaKcalText` e `pesoText` para criar sua célula
                                FoodItemCell(showImage: false, image: nil, title: food.nome, weight: pesoText, calories: energiaKcalText) {
                                    // Defina a ação para adicionar a comida selecionada
                                    onAddMeal(food)
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
                        
                        Image("SearchIngrImage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth * 0.38, height: screenHeight * 0.15)
                            .padding()
                        
                        Text("Você ainda não pesquisou nenhum nome de alimento")
                            .foregroundColor(Color.laranjaMacros)
                            .font(.title3)
                            .padding()
                        
                        Spacer()
                    }
                    .padding(.top, -screenWidth * 0.12)
                }
                
                // Lista de Resultados da Pesquisa
                VStack {
                    ScrollView {
                        ForEach(filteredFoods) { food in
                            let energiaKcal = food.detalhesNutricionais.first { $0.componente == "Energia" && $0.unidade == "kcal" }
                            let energiaKcalText = energiaKcal.map { "\($0.valor) Cal" } ?? "N/A"
                            
                            // Buscar o detalhe de peso, se disponível
                            let pesoText = "100 gramas" // Isso pode ser ajustado dependendo do seu modelo
                            
                            // Agora você pode usar `energiaKcalText` e `pesoText` para criar sua célula
                            FoodItemCell(showImage: false, image: nil, title: food.nome, weight: pesoText, calories: energiaKcalText) {
                                // Defina a ação para adicionar a comida selecionada
                                print("Adicionar \(food.nome)")
                                self.selectedFoods.append(food)
                                self.searchText = ""
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top, screenHeight * 0.02)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                .zIndex(1)
                }
                .padding(.horizontal)
            }
        }
        .onReceive(speechRecognizerManager.$recognizedText) { newValue in
            print("Texto reconhecido atualizado: \(newValue)")
            searchText = newValue
        }
        .ignoresSafeArea(.keyboard)
    }
}

// Dados de amostra para o preview
struct FoodSampleData {
    static let sampleFoods = [
        Food(codigo: "1", nome: "Maçã", grupo: "Frutas", marca: "", detalhesNutricionais: []),
        Food(codigo: "1", nome: "Banana", grupo: "Frutas", marca: "", detalhesNutricionais: []),
        Food(codigo: "1", nome: "Arroz", grupo: "Grãos", marca: "", detalhesNutricionais: [])
    ]
}

// Definindo um PreviewProvider para SearchFoodView
struct SearchFoodView_Previews: PreviewProvider {
    @State static var searchText = ""
    @State static var selectedFoods = FoodSampleData.sampleFoods

    static var previews: some View {
        SearchFoodView(
            searchText: $searchText,
            speechRecognizerManager: SpeechRecognizerManager(),
            selectedFoods: $selectedFoods, // Passando como Binding
            filteredFoods: FoodSampleData.sampleFoods,
            selectFood: { food in
                print("Alimento selecionado: \(food.nome)")
            }, onAddMeal: { food in
                print("addmeal")
            }
        )
    }
}

