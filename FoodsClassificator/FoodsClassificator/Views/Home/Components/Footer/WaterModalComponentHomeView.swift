//
//  WaterModalComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 25/03/24.
//

import SwiftUI

struct WaterModalComponentHomeView: View {
    @Environment(FooterHomeViewModel.self) var footerHomeViewModel
    @Environment(\.dismiss) private var dismiss
    @Binding var isPresented: Bool
    
    @State var showLiterPopover: Bool = false
    @State var showCapacityPopover: Bool = false
    
    @State var selectedCapacityIndex = 0
    @State var selectedLitersIndex = 0
    @State var selectedMillilitersIndex = 0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                        HStack {
                            Text("Meta")
                                .font(.title2)
                                .foregroundStyle(Color.black)
                            Spacer()
                        }
                        
                        Button(action: {
                            showLiterPopover.toggle()
                        }, label: {
                            VStack{
                                Text("\(footerHomeViewModel.formattedTotalWater) Litros")
                                    .foregroundStyle(Color.black)
                                    .font(.title)
                            }.padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.laranjaBrilhante)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                               
                        })
                        .popover(isPresented: $showLiterPopover, content: {
                            HStack {
                                Picker("Litros", selection: $selectedLitersIndex) {
                                    ForEach(0..<footerHomeViewModel.litersOptions.count, id: \.self) {
                                        Text("\(footerHomeViewModel.litersOptions[$0])")
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .onChange(of: selectedLitersIndex) { _, newValue in
                                    footerHomeViewModel.litersSelected = Double(footerHomeViewModel.litersOptions[newValue])
                                }
                                
                                Text(".")
                                
                                Picker("Millilitros", selection: $selectedMillilitersIndex) {
                                    ForEach(0..<footerHomeViewModel.milliliterOptions.count, id: \.self) {
                                        Text("\(footerHomeViewModel.milliliterOptions[$0])")
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .onChange(of: selectedMillilitersIndex) { _, newValue in
                                    footerHomeViewModel.milliliterSelected = Double(footerHomeViewModel.milliliterOptions[newValue])
                                }
                                Text("L")
                            }
                            .presentationCompactAdaptation(.popover)
                        })
                        
                        HStack {
                            Text("Recipiente")
                                .font(.title2)
                                .foregroundStyle(.black)
                            Spacer()
                        }.padding(.top)
                        
                        HStack {
                            Spacer()
                            VStack {
                                Button(action: {
                                    footerHomeViewModel.isBottleSelected = false
                                    print("copo selecionado")
                                }, label: {
                                    
                                    VStack {
                                        Image("cup")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                    }
                                    .padding()
                                    .background(.laranjaBrilhante)
                                    .opacity(footerHomeViewModel.isBottleSelected ? 0.5 : 1.0)
                                    .clipShape(Circle())
                                    
                                })
                                
                                Text("Copo")
                                    .foregroundStyle(Color.black)
                                
                            }
                            Spacer()
                            
                            VStack {
                                Button(action: {
                                    footerHomeViewModel.isBottleSelected = true
                                    print("Garrafa selecionado")
                                }, label: {
            
                                    VStack {
                                        Image("WaterBottle")
                                            .resizable()
                                            .frame(width: 42, height: 42)
                                    }
                                    .padding()
                                    .background(.laranjaBrilhante)
                                    .opacity(footerHomeViewModel.isBottleSelected ? 1 : 0.5)
                                    .clipShape(Circle())
                                    
                                })

                                Text("Garrafa")
                                    .foregroundStyle(Color.black)
                            }
                            Spacer()
                        }

                        Button(action: {
                            showCapacityPopover.toggle()
                            print("Capacity popover clicker")
                        }, label: {
                        
                            HStack{
                                Text("Capacidade")
                                    .font(.headline)
                                Spacer()
                                Text("\(footerHomeViewModel.formattedCapacity)")
                                    .foregroundStyle(Color.black)
                                    .font(.headline)
                            }.padding(10)
                            .frame(maxWidth: .infinity)
                            .background(.laranjaBrilhante)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                        })
                        .popover(isPresented: $showCapacityPopover, content: {
                            HStack {
                                Picker("ml", selection: $selectedCapacityIndex) {
                                    ForEach(0..<footerHomeViewModel.capacityOptions.count, id: \.self) {
                                        Text("\(footerHomeViewModel.capacityOptions[$0]) ml")
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .onChange(of: selectedCapacityIndex) { _, newValue in
                                    footerHomeViewModel.capacitySelected = Double(footerHomeViewModel.capacityOptions[newValue])
                                }
                            }

                            .presentationCompactAdaptation(.popover)
                        })
                    }
     
                    .padding()
                }
                .navigationTitle("Água")
            
        }
        Button("Done") {
            isPresented = false
            dismiss()
        }
        .foregroundStyle(Color.red)
    }
}


#Preview {
    var footerHomeViewModel = FooterHomeViewModel()
    return WaterModalComponentHomeView(isPresented: .constant(true)) // Substitua true pelo valor inicial desejado para isPresented
        .environment(footerHomeViewModel)
    
}
