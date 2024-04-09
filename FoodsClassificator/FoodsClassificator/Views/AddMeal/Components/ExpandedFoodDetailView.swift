//
//  ExpandedFoodDetailView.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 08/04/24.
//

import SwiftUI

struct ExpandedFoodDetailView: View {
    var showImage: Bool
    var image: Image?
    let food: Food
    @State private var selectedName: String
    @State private var selectedWeight: String
    let onSave: (Food) -> Void
    let onCancel: () -> Void
    
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    init(showImage: Bool, food: Food, onSave: @escaping (Food) -> Void, onCancel: @escaping () -> Void) {
        self.showImage = showImage
        self.food = food
        self.onSave = onSave
        self.onCancel = onCancel
        _selectedName = State(initialValue: food.nome)
        _selectedWeight = State(initialValue: "100 g") // O peso inicial pode vir de outro lugar, se necessário
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        if showImage {
                            Image("BatataFrita")
                                .resizable()
//                                .aspectRatio(contentMode: .fit)
                                .frame(width: screenWidth * 0.2, height: screenWidth * 0.2)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.leading, screenWidth * 0.1)
                        }
                        
                        HStack {
                            VStack(alignment: .leading, spacing: -screenHeight * 0.025) {
                                CustomPickerView(food: food, selectedName: $selectedName, widthPercent: 0.5, selectedWeight: $selectedWeight, hasOther: true)
                                
                                HStack(spacing: -screenWidth * 0.01) {
                                    CustomPickerView(food: food, selectedName: $selectedWeight, widthPercent: 0.25, selectedWeight: $selectedWeight, hasOther: false)
                                    
                                    Text("\(food.detalhesNutricionais.first(where: { $0.componente == "Energia" })?.valor ?? "0") cal")
                                        .bold()
                                        .lineLimit(1)
                                }
                            }
                        }
                        .frame(width: screenWidth * 0.65)
                        .padding(.leading, -screenWidth * 0.06)
                        
                        Spacer()
                        
                        Button(action: {
                            onSave(food)
                        }) {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.black)
                                .font(.title)
                        }
                    }
                    .frame(width: screenWidth * 0.8)
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Informações nutricionais").bold()
                
                VStack {
                    ForEach(food.detalhesNutricionais) { detail in
                        HStack {
                            if detail.componente != "Energia" {
                                Text("\(detail.componente): ")
                                Spacer()
                                Text("\(detail.valor) g")
                            }
                        }
                    }
                }
                .padding(.top, screenHeight * 0.001)
            }
            .padding(.bottom, screenWidth * 0.03)
        }
        .padding()
        .frame(width: screenWidth - 30, height: screenHeight * 0.3)
        .background(Color.laranjaMacros)
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
    }
}

// PreviewProvider
struct ExpandedFoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleFood = Food(
            codigo: "001",
            nome: "Batata frita",
            grupo: "Snacks",
            marca: "Marca X",
            detalhesNutricionais: [
                Details(componente: "Energia", unidade: "kcal", valor: "300"),
                Details(componente: "Carboidratos", unidade: "g", valor: "41"),
                Details(componente: "Proteínas", unidade: "g", valor: "3.7"),
                Details(componente: "Fibras", unidade: "g", valor: "3.3"),
                Details(componente: "Gorduras", unidade: "g", valor: "17")
            ]
        )
        
        ExpandedFoodDetailView(
            showImage: true, food: sampleFood,
            onSave: { food in
                // Aqui você trataria a lógica de salvar as mudanças
                print("Salvo: \(food)")
            },
            onCancel: {
                // Aqui você trataria o cancelamento
                print("Cancelado.")
            }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
