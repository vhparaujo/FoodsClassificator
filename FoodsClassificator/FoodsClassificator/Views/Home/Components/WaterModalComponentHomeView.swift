//
//  WaterModalComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 25/03/24.
//

import SwiftUI

struct WaterModalComponentHomeView: View {
    @State private var selectedLitersIndex = 0
    let litersOptions = stride(from: 1, through: 10, by: 1).map { "\($0) - Litros" }
    
    @State private var isCupSelected = false
    @State private var isBottleSelected = true
    
    @State private var selectedCapacityIndex = 0
    let capacityOptions = stride(from: 50, through: 2000, by: 50).map { "\($0) ml" }
    
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text("Meta Diária")
                    Spacer()
                }
                .padding(.horizontal)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.orange)
                    .frame(height: 50)
                    .padding()
                    .overlay(
                        VStack {
                            Picker("Litros", selection: $selectedLitersIndex) {
                                ForEach(0..<litersOptions.count, id: \.self) { index in
                                    Text(litersOptions[index])
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .padding()
                        }
                    )
                
                HStack {
                    Text("Recipiente")
                        .padding(.horizontal)
                    Spacer()
                }
                
                HStack(spacing: geometry.size.width * 0.1) {
                    Circle()
                        .foregroundStyle(Color.orange)
                        .opacity(isCupSelected ? 1 : 0.4)
                        .overlay {
                            Button(action: {
                                isCupSelected = true
                                isBottleSelected = false
                                print("Copo selecionado")
                            }, label: {
                                Image("cup")
                            })
                            .padding(.horizontal)
                        }
                        .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                    
                    
                    Circle()
                        .foregroundStyle(Color.orange)
                        .opacity(isBottleSelected ? 1 : 0.5)
                        .overlay {
                            Button(action: {
                                isCupSelected = false
                                isBottleSelected = true
                                print("Garrafa selecionado")
                            }, label: {
                                Image("waterbottle")
                            })
                            .padding(.horizontal)
                        }
                        .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                }
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.orange)
                    .frame(height: 50)
                    .padding()
                    .overlay(
                        HStack {
                            Text("Capacidade")
                                .padding()
                            
                            Picker("Litros", selection: $selectedCapacityIndex) {
                                ForEach(0..<capacityOptions.count, id: \.self) { index in
                                    Text(capacityOptions[index])
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
                            .padding()
                        
                    )
            }
        }
    }
}


#Preview {
    WaterModalComponentHomeView()
}
