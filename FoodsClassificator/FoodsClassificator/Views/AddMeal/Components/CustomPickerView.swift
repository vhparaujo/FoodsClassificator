//
//  CustomPickerView.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 08/04/24.
//

import SwiftUI

struct CustomPickerView: View {
    let food: Food
    
    @State private var showingPicker = false
    @Binding var selectedName: String
    var widthPercent: CGFloat
    @Binding var selectedWeight: String
    @State var hasOther: Bool
    
    private let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            Button(action: {
                self.showingPicker = true
            }) {
                HStack {
                    Text(selectedName)
                        .foregroundColor(.black)
                        .font(.subheadline)
                    Spacer()
                    
                    if hasOther {
                        Text("Outro")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
            }
            .frame(width: screenWidth * widthPercent, height: 40)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 1)
            )
            
            if showingPicker {
                VStack {
                    Picker("Selecione o alimento", selection: $selectedName) {
                        Text(food.nome).tag(food.nome)
                        if hasOther {
                            Text("Outro").tag("Outro")
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Picker("Peso", selection: $selectedWeight) {
                        ForEach(0..<1000) { weight in
                            Text("\(weight) g").tag("\(weight) g")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 150)
                    .clipped()
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(width: screenWidth * widthPercent)
                .labelsHidden()
                .onChange(of: selectedWeight) { newValue in
                    self.showingPicker = false // Esconde o picker quando uma seleção é feita
                }
            }
        }
        .padding()
    }
}
