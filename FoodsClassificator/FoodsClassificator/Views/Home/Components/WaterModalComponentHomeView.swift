//
//  WaterModalComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 25/03/24.
//

import SwiftUI

struct WaterModalComponentHomeView: View {
    @State  var selectedLitersIndex = 0
    let litersOptions = stride(from: 1, through: 15, by: 1).map { $0 }
    @Binding  var litrosSelecionados:Int
    
    @Binding  var isCupSelected:Bool
    @Binding  var isBottleSelected:Bool
    
    
    @State  var selectedCapacityIndex = 0
    let capacityOptions = stride(from: 50, through: 2000, by: 50).map { $0 }
    @Binding  var capacidadeSelecionada:Int
    
    
    @Binding var isPresented: Bool
    
    init(litrosSelecionados: Binding<Int>, capacidadeSelecionada: Binding<Int> ,isCupSelected: Binding<Bool>, isBottleSelected: Binding<Bool>, isPresented: Binding<Bool>) {
        self._litrosSelecionados = litrosSelecionados
        self._capacidadeSelecionada = capacidadeSelecionada
        self._isCupSelected = isCupSelected
        self._isBottleSelected = isBottleSelected
        self._isPresented = isPresented
        
        // Inicializa selectedLitersIndex com o valor atual de litrosSelecionados
        _selectedLitersIndex = State(initialValue: litersOptions.firstIndex(of: litrosSelecionados.wrappedValue) ?? 0 )
//        _selectedCapacityIndex = State(initialValue: capacidadeSelecionada.wrappedValue)
        _selectedCapacityIndex = State(initialValue: capacityOptions.firstIndex(of: capacidadeSelecionada.wrappedValue) ?? 0)

    }
    
    var body: some View {
        NavigationStack {
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
                                        let litroText = litersOptions[index] > 1 ? "Litros" : "Litro"
                                                Text("\(litersOptions[index]) \(litroText)")
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .padding()
                                .onChange(of: selectedLitersIndex) { _, newValue in
                                    litrosSelecionados = litersOptions[newValue]
                                }
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
                                
                                Picker("ml", selection: $selectedCapacityIndex) {
                                    ForEach(0..<capacityOptions.count, id: \.self) { index in
                                        Text("\(capacityOptions[index]) ml")
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .onChange(of: selectedCapacityIndex) { _, newValue in
                                    capacidadeSelecionada = capacityOptions[newValue]
                                }
                            }
                                .padding()
                            
                        )
                }
                .padding()
            }
        }
        Button("Done") {
            isPresented = false
        }
    }
}


#Preview {
    HomeView()
}
