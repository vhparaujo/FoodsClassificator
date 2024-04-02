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
    @Binding  var litersSelected:Int
    
    @State  var selectedMillilitersIndex = 0
    let milliliterOptions = stride(from: 00, through: 950, by: 50).map { $0 }
    @Binding  var milliliterSelected:Int
    
    @State  var selectedCapacityIndex = 0
    let capacityOptions = stride(from: 50, through: 5000, by: 50).map { $0 }
    @Binding  var capacitySelected:Int
    
    @Binding  var isCupSelected:Bool
    @Binding  var isBottleSelected:Bool
    
    @Binding var isPresented: Bool
    @State private var showLiterPopover: Bool = false
    @State private var showCapacityPopover: Bool = false
    
    
    init(litrosSelecionados: Binding<Int>, mililiterSelected: Binding<Int>,capacidadeSelecionada: Binding<Int> ,isCupSelected: Binding<Bool>, isBottleSelected: Binding<Bool>, isPresented: Binding<Bool>, showPopover: Binding<Bool>) {
        // Inicializa selectedLitersIndex com o valor atual de litrosSelecionados
        _selectedLitersIndex = State(initialValue: litersOptions.firstIndex(of: litrosSelecionados.wrappedValue) ?? 0 )
        self._litersSelected = litrosSelecionados
        
        _selectedMillilitersIndex = State(initialValue: milliliterOptions.firstIndex(of: mililiterSelected.wrappedValue) ?? 0 )
        self._milliliterSelected = mililiterSelected
        
        _selectedCapacityIndex = State(initialValue: capacityOptions.firstIndex(of: capacidadeSelecionada.wrappedValue) ?? 0)
        self._capacitySelected = capacidadeSelecionada
        
        self._isCupSelected = isCupSelected
        self._isBottleSelected = isBottleSelected
        
        self._isPresented = isPresented
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Text("Meta")
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        showLiterPopover.toggle()
                        print("popover clicker")
                    }, label: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.orange)
                            .frame(height: 50)
                            .padding()
                            .overlay(
                                Text("\(litersSelected),\(milliliterSelected) \(litersSelected > 1 ? "Litros" : "Litro") ")
                                    .foregroundStyle(Color.black)
                            )
                    })
                    .popover(isPresented: $showLiterPopover, content: {
                        HStack {
                            Picker("Litros", selection: $selectedLitersIndex) {
                                ForEach(0..<litersOptions.count, id: \.self) { index in
                                    Text("\(litersOptions[index])")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .onChange(of: selectedLitersIndex) { _, newValue in
                                litersSelected = litersOptions[newValue]
                            }
                            Text(",")
                            Picker("Millilitros", selection: $selectedMillilitersIndex) {
                                ForEach(0..<milliliterOptions.count, id: \.self) { index in
                                    Text("\(milliliterOptions[index])")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .onChange(of: selectedMillilitersIndex) { _, newValue in
                                milliliterSelected = milliliterOptions[newValue]
                            }
                            Text("L")
                        }
                        .padding()
                        .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.2)

                        .presentationCompactAdaptation(.popover)
                    })
                    
                    HStack {
                        Text("Recipiente")
                            .padding(.horizontal)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        VStack {
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
                            Text("Copo")
                        }
                        Spacer()
                        
                        VStack {
                            Circle()
                                .foregroundStyle(Color.orange)
                                .opacity(isBottleSelected ? 1 : 0.5)
                                .overlay {
                                    Button(action: {
                                        isCupSelected = false
                                        isBottleSelected = true
                                        print("Garrafa selecionado")
                                    }, label: {
                                        Image("WaterBottle")
                                            .resizable()
                                            .scaledToFit()
                                    })
                                    .padding()
                                }
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                            Text("Garrafa")
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    
                    Button(action: {
                        showCapacityPopover.toggle()
                        print("Capacity popover clicker")
                    }, label: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.orange)
                            .frame(height: 50)
                            .padding()
                            .overlay(
                                HStack {
                                    Text("Capacidade")
                                    Text("\(capacitySelected) ml")
                                }
                                    .foregroundStyle(Color.black)
                            )
                        
                    })
                    .popover(isPresented: $showCapacityPopover, content: {
                        HStack {
                            Picker("ml", selection: $selectedCapacityIndex) {
                                ForEach(0..<capacityOptions.count, id: \.self) { index in
                                    Text("\(capacityOptions[index]) ml")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .onChange(of: selectedCapacityIndex) { _, newValue in
                                capacitySelected = capacityOptions[newValue]
                            }
                        }
                        .padding()
                        .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2)
                        .presentationCompactAdaptation(.popover)
                    }
                             
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
