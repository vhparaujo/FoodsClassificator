//
//  NutritionModalView.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 29/02/24.
//

import SwiftUI

struct NutritionModalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let nutrients: [Nutrient]
    let properties: [Property]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    
                    Text("100g")
                        .padding(.trailing, 20)
                }
                
                Divider()
                
                List(nutrients, id: \.name) { nutrient in
                    let _ = print("Renderizando nutriente: \(nutrient.name)")
                    HStack {
                        Text("\(nutrient.name)(\(nutrient.unit))")
                        Spacer()
                        Text("\(Double(nutrient.amount) * 100, specifier: "%.2f")")
                        let _ = print(nutrient.amount)
                    }
                }
                .listStyle(PlainListStyle())
                
                Text("Properties")
                    .padding(.top, 24)
                
                List(properties, id: \.name) { property in
                    let _ = print("Renderizando propriedade: \(property.name)")
                    HStack {
                        Text("\(property.name)")
                        Spacer()
                        Text("\(property.amount, specifier: "%.2f") \(property.unit)")
                    }
                }
                .listStyle(PlainListStyle())
            }
            .padding(.top, -6)
            .navigationBarTitle("Nutrition Information", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
