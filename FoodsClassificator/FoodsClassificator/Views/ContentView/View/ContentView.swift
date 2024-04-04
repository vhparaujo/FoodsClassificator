////
////  ContentView.swift
////  ClassificacaoFrutasTeste
////
////  Created by Gabriel Ribeiro Noronha on 01/03/24.
////
//
//import SwiftUI
//import Vision
//
//struct NutritionData: Identifiable {
//    var id: UUID = UUID()
//    var nutrients: [Nutrient]
//    var properties: [Property]
//}
//
//struct ContentView: View {
//    @StateObject private var viewModel = ContentViewModel()
//    
//    @State private var showImagePicker = false
//    @State private var image: UIImage?
//    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
//    @State private var observations: [VNRecognizedObjectObservation] = []
//    let buttonsColor: [Color] = [.blue, .red, .green, .yellow, .orange, .purple, .pink, .gray, .black, .white]
//    @State private var findingIngredients: [String] = []
//    
//    var body: some View {
//        NavigationStack{
//            VStack(spacing: 20) {
//                if let image = image {
//                    NewBoundingBoxesView(image: image, observations: observations)
//                        .frame(width: 300, height: 300) // Ajuste conforme necessário
//                }
//                
//                // Lista que mostra a confiança
//                List(observations, id: \.uuid) { observation in
//                    ForEach(observation.labels.filter { $0.confidence > 0.5 }, id: \.identifier) { label in
//                        Text(" \(label.identifier): \(label.confidence)")
//                        
//                    }
//                }
//                
//              
//                // 1. Pegar a posicao central de cada bounding box e salvar num array para posicionar o botao
//                List(findingIngredients, id: \.self) { ingredient in
//                    Button(ingredient) {
//                        print("")
//                        viewModel.getIngredientID(query: ingredient)
//                    }
//                    .padding(10)
//                    .foregroundStyle(.white)
//                    .background(buttonsColor.randomElement() ?? .blue)
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                }
//                
//                
//                
//                // Botão para escolher da biblioteca
//                Button(action: {
//                    self.sourceType = .photoLibrary
//                    self.showImagePicker = true
//                }) {
//                    Text("")
//                        .foregroundColor(.white)
//                        .frame(minWidth: 0, maxWidth: .infinity)
//                        .padding()
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
//                .buttonStyle(PlainButtonStyle()) // Remove o estilo padrão do botão para iOS
//                
//                // Botão para usar a câmera
//                Button(action: {
//                    self.sourceType = .camera
//                    self.showImagePicker = true
//                }) {
//                    Text("")
//                        .foregroundColor(.white)
//                        .frame(minWidth: 0, maxWidth: .infinity)
//                        .padding()
//                        .background(Color.green)
//                        .cornerRadius(10)
//                }
//                .buttonStyle(PlainButtonStyle()) // Remove o estilo padrão do botão para iOS
//            }
//        }
//        .padding() // Adiciona padding em torno da VStack para dar mais espaço
//        .sheet(isPresented: $showImagePicker) {
//            NewImagePicker(selectedImage: self.$image, sourceType: self.sourceType, completion: { results in
//                DispatchQueue.main.async {
//                    // Filtra os resultados para incluir apenas aqueles com confiança > 50%
//                    let filteredResults = results.filter { observation in
//                        observation.labels.contains(where: { $0.confidence > 0.5 })
//                    }
//                    // Atualiza o estado para as bounding boxes
//                    self.observations = filteredResults
//                    
//                    // Limpa o array para evitar duplicatas caso esta função seja chamada múltiplas vezes
//                    self.findingIngredients.removeAll()
//                    
//                    // Itera sobre cada observação e seus labels para extrair os identificadores
//                    for observation in filteredResults {
//                        for label in observation.labels where label.confidence > 0.5 {
//                            self.findingIngredients.append(label.identifier)
//                        }
//                    }
//                }
//            })
//        }
//        .sheet(item: $viewModel.nutritionDataToShow) { nutritionData in
//            NutritionModalView(nutrients: nutritionData.nutrients, properties: nutritionData.properties)
//        }
//    }
//}
//
//
//#Preview {
//    ContentView()
//}
