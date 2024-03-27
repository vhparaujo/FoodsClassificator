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
                    
                    Text("")
                        .padding(.trailing, 20)
                }
                
                Divider()
                
                List(nutrients, id: \.name) { nutrient in
                    let _ = print(" \(nutrient.name)")
                    HStack {
                        Text("\(nutrient.name)(\(nutrient.unit))")
                        Spacer()
                        Text("\(Double(nutrient.amount) * 100, specifier: "")")
                        let _ = print(nutrient.amount)
                    }
                }
                .listStyle(PlainListStyle())
                
                Text("")
                    .padding(.top, 24)
                
                List(properties, id: \.name) { property in
                    let _ = print(" \(property.name)")
                    HStack {
                        Text("\(property.name)")
                        Spacer()
                        Text("\(property.amount, specifier: "") \(property.unit)")
                    }
                }
                .listStyle(PlainListStyle())
            }
            .padding(.top, -6)
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
