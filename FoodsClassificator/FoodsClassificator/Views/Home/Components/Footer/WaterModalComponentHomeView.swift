//
//  WaterModalComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 25/03/24.
//

import SwiftUI

struct WaterModalComponentHomeView: View {
    @Environment(FooterHomeViewModel.self) var footerHomeViewModel
    
    @Binding var isPresented: Bool
    
    @State var showLiterPopover: Bool = false
    @State var showCapacityPopover: Bool = false

    @State var selectedCapacityIndex = 0
    @State var selectedLitersIndex = 0
    @State var selectedMillilitersIndex = 0
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Text("Meta Diária")
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
                                Text("\(footerHomeViewModel.formattedTotalWater) Litros")
                                    .foregroundStyle(Color.black)
                            )
                    })
                    .popover(isPresented: $showLiterPopover, content: {
                        HStack {
                            Picker("Litros", selection: $selectedLitersIndex) {
                                ForEach(0..<footerHomeViewModel.litersOptions.count, id: \.self) { index in
                                    Text("\(footerHomeViewModel.litersOptions[index])")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .onChange(of: footerHomeViewModel.selectedLitersIndex) { _, newValue in
                                footerHomeViewModel.updateSelectedValues()
                            }
                            
                            Text(".")
                                .padding(.zero)
                            
                            Picker("Millilitros", selection: $selectedMillilitersIndex) {
                                ForEach(0..<footerHomeViewModel.milliliterOptions.count, id: \.self) { index in
                                    Text("\(footerHomeViewModel.milliliterOptions[index])")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .onChange(of: footerHomeViewModel.selectedMillilitersIndex) { _, newValue in
                                    footerHomeViewModel.updateSelectedValues()
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
                                .opacity(footerHomeViewModel.isCupSelected ? 1 : 0.4)
                                .overlay {
                                    Button(action: {
                                        footerHomeViewModel.isCupSelected = true
                                        footerHomeViewModel.isBottleSelected = false
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
                                .opacity(footerHomeViewModel.isBottleSelected ? 1 : 0.5)
                                .overlay {
                                    Button(action: {
                                        footerHomeViewModel.isCupSelected = false
                                        footerHomeViewModel.isBottleSelected = true
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
                                    Text("\(footerHomeViewModel.formattedCapacity)")
                                }
                                    .foregroundStyle(Color.black)
                            )
                        
                    })
                    .popover(isPresented: $showCapacityPopover, content: {
                        HStack {
                            Picker("ml", selection: $selectedCapacityIndex) {
                                ForEach(0..<footerHomeViewModel.capacityOptions.count, id: \.self) { index in
                                    Text("\(footerHomeViewModel.capacityOptions[index]) ml")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .onChange(of: footerHomeViewModel.selectedCapacityIndex) { _, newValue in
                                footerHomeViewModel.updateSelectedValues()
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
    var footerHomeViewModel = FooterHomeViewModel()
    return WaterModalComponentHomeView(isPresented: .constant(true)) // Substitua true pelo valor inicial desejado para isPresented
        .environment(footerHomeViewModel)
    
}

#Preview{
    var footerHomeViewModel = FooterHomeViewModel()
    return HomeView()
        .environment(footerHomeViewModel)
}
