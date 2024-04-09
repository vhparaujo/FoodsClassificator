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
    @State private var selectedWeight: Int
    let onSave: (Food, Int) -> Void
    
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    init(showImage: Bool, food: Food, onSave: @escaping (Food, Int) -> Void) {
        self.showImage = showImage
        self.food = food
        self.onSave = onSave
        _selectedName = State(initialValue: food.nome)
        _selectedWeight = State(initialValue: 100)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                if showImage, let image = image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: screenWidth * 0.2, height: screenWidth * 0.2)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.leading, screenWidth * 0.1)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Picker("Selecione o alimento", selection: $selectedName) {
                            Text("\(food.nome)                    ").tag(food.nome)
                                .lineLimit(1)
                        }
                        .pickerStyle(MenuPickerStyle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 1)
                            
                        )
                        
                        HStack(spacing: screenWidth * 0.024) {
                            Picker("Peso", selection: $selectedWeight) {
                                ForEach(0..<1000) {
                                    Text("\($0) gramas").tag($0)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            
                            Text("\(valorNutricionalPorPeso(componente: "Energia")) cal")
                                .lineLimit(1)
                                .padding(screenWidth * 0.018)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                        }
                    }
                }
                .frame(width: screenWidth * 0.65)
                .padding(.leading, -screenWidth * 0.05)
                
                Spacer()
                
                Button(action: {
                    // Chama getUpdatedFoodDetails para obter os detalhes nutricionais atualizados
                        let updatedDetails = getUpdatedFoodDetails()

                        // Cria uma nova instância do alimento com os detalhes atualizados
                        let updatedFood = Food(codigo: food.codigo, nome: food.nome, grupo: food.grupo, marca: food.marca, detalhesNutricionais: updatedDetails)
                    onSave(updatedFood, selectedWeight)
                }) {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .fontWeight(.light)
                }
                .padding(.leading, -screenWidth * 0.06)
            }
            .frame(width: screenWidth * 0.8)
            .padding(.leading, screenWidth * 0.04)
            .padding(.top, -screenHeight * 0.02)
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Informações nutricionais").bold()
                
                VStack {
                    ForEach(food.detalhesNutricionais) { detail in
                        if ["Carboidrato total", "Proteína", "Fibra alimentar", "Lipídios"].contains(detail.componente) {
                            HStack {
                                Text("\(detail.componente): ")
                                Spacer()
                                Text("\(valorNutricionalPorPeso(componente: detail.componente)) g")
                            }
                        }
                    }
                }
                .padding(.top, screenHeight * 0.001)
            }
            .padding(.bottom, screenWidth * 0.03)
        }
        .padding()
        .frame(width: screenWidth * 0.9, height: screenHeight * 0.3)
        .background(Color.laranjaMacros)
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
    }
    
    // Função para calcular os valores nutricionais baseados no peso selecionado
    private func valorNutricionalPorPeso(componente: String) -> String {
        if componente == "Energia" {
            // Busca especificamente por Energia com unidade kcal
            guard let valor = food.detalhesNutricionais.first(where: { $0.componente == componente && $0.unidade == "kcal" })?.valor else {
                print("Valor de Energia não encontrado para componente \(componente)")
                return "0" // Retorna "0" se não encontrar o valor de Energia com unidade kcal
            }
            if let valorDouble = Double(valor) {
                let valorCalculado = (valorDouble * Double(selectedWeight)) / 100.0
                print("Valor de Energia encontrado: \(valor). Peso selecionado: \(selectedWeight). Valor calculado: \(valorCalculado)")
                return "\(String(format: "%.f", valorCalculado))" // Retorna valor calculado com a unidade kcal
            }
            print("Não foi possível converter o valor de Energia para Double: \(valor)")
            return valor // Retorna o valor original se não puder converter para Double
        } else {
            // Para outros componentes, processa sem adicionar a unidade
            guard let valor = food.detalhesNutricionais.first(where: { $0.componente == componente })?.valor else {
                print("Valor não encontrado para componente \(componente)")
                return "0"
            }
            // Substitui vírgulas por pontos no valor
                    let valorSemVirgula = valor.replacingOccurrences(of: ",", with: ".")
                    
                    // Tenta converter o valor para Double
                    if let valorDouble = Double(valorSemVirgula) {
                        let valorCalculado = (valorDouble * Double(selectedWeight)) / 100.0
                        return "\(String(format: "%.f", valorCalculado))" // Retorna apenas o valor calculado
                    }
            print("Não foi possível converter o valor para Double: \(valor)")
            return valor // Retorna o valor original se não puder converter para Double
        }
    }

    func getUpdatedFoodDetails() -> [Details] {
        return food.detalhesNutricionais.map { detail in
            let valorAtualizado = valorNutricionalPorPeso(componente: detail.componente)
            // Assume que valorAtualizado é sempre em gramas, exceto para Energia, que não adiciona 'g' no final.
            let unidadeAtualizada = detail.componente == "Energia" ? "" : ""
            return Details(componente: detail.componente, unidade: detail.unidade, valor: "\(valorAtualizado)\(unidadeAtualizada)")
        }
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
            onSave: { food, weight in // Ajuste para receber dois parâmetros
                // Aqui você trataria a lógica de salvar as mudanças
                print("Salvo: \(food) com peso \(weight)")
            }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
