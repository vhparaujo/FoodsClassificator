//
//  TesteLeituraJSON.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 20/03/24.
//

import SwiftUI

struct TesteLeituraJSON: View {
    
    @State var foodData = FoodData()
    
    var body: some View {
        VStack{
            Text("\(foodData.foods.count)")
            List(foodData.foods) { food in
                Text(food.nome)
//                Text(food.codigo)
//                Text(food.grupo)
                ForEach(food.detalhesNutricionais, id: \.self) { details in
                    Text(details.componente)
                    Text(details.unidade)
                    Text(details.valor)
                }
            }
        }
        .task {
            do {
               try await foodData.loadJson()
            }  catch Errors.invalidURL {
                print("URL invalida")
            } catch Errors.invalidData {
                print("Dado invalido")
            } catch {
                print("Erro inesperado")
            }
        }
    }
}

#Preview {
    TesteLeituraJSON()
}
