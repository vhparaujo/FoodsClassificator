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
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Text("Meta")
                            .foregroundStyle(Color.black)
                        Spacer()
                    }
                    
                    Button(action: {
                        showLiterPopover.toggle()
                        print("popover clicker")
                    }, label: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.orange)
                            .overlay(
                                Text("\(footerHomeViewModel.formattedTotalWater) Litros")
                                    .foregroundStyle(Color.black)
                                    .padding()
                                    .font(.system(size: 24))
                                    .bold()
                            )
                    })
                    .popover(isPresented: $showLiterPopover, content: {
                        HStack {
                            Picker("Litros", selection: $selectedLitersIndex) {
                                ForEach(0..<footerHomeViewModel.litersOptions.count) {
                                    Text("\(footerHomeViewModel.litersOptions[$0])")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .onChange(of: selectedLitersIndex) { _, newValue in
                                footerHomeViewModel.litersSelected = Double(footerHomeViewModel.litersOptions[newValue])
                            }
                            
                            Text(".")
                            //                                .padding(.zero)
                            
                            Picker("Millilitros", selection: $selectedMillilitersIndex) {
                                ForEach(0..<footerHomeViewModel.milliliterOptions.count) {
                                    Text("\(footerHomeViewModel.milliliterOptions[$0])")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .onChange(of: selectedMillilitersIndex) { _, newValue in
                                footerHomeViewModel.milliliterSelected = Double(footerHomeViewModel.milliliterOptions[newValue])
                            }
                            Text("L")
                        }
                        //                        .padding()
                        .presentationCompactAdaptation(.popover)
                    })
                    
                    HStack {
                        Text("Recipiente")
                        //                            .padding(.horizontal)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        VStack {
                            Button(action: {
                                footerHomeViewModel.isBottleSelected = false
                                print("Garrafa selecionado")
                            }, label: {
                                Circle()
                                    .overlay{
                                        Image("cup")
                                            .resizable()
                                            .scaledToFit()
                                            .padding()
                                    }
                            })
                            .foregroundStyle(Color.orange)
                            .opacity(footerHomeViewModel.isBottleSelected ? 0.5 : 1.0)
                            Text("Copo")
                                .foregroundStyle(Color.black)
                            
                        }
                        Spacer()
                        
                        VStack {
                            Button(action: {
                                footerHomeViewModel.isBottleSelected = true
                                print("Garrafa selecionado")
                            }, label: {
                                Circle()
                                    .overlay{
                                        Image("WaterBottle")
                                            .resizable()
                                            .scaledToFit()
                                            .padding()
                                    }
                            })
                            .foregroundStyle(Color.orange)
                            .opacity(footerHomeViewModel.isBottleSelected ? 1 : 0.5)
                            Text("Garrafa")
                                .foregroundStyle(Color.black)
                        }
                        Spacer()
                    }
                    .frame(height:geometry.size.height * 0.34)

                    Button(action: {
                        showCapacityPopover.toggle()
                        print("Capacity popover clicker")
                    }, label: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.orange)
                        //                            .frame(height: 50)
                        //                            .padding()
                            .overlay(
                                HStack {
                                    Text("Capacidade")
                                    Spacer()
                                    Text("\(footerHomeViewModel.formattedCapacity)")
                                }
                                    .padding(.horizontal)
                                    .foregroundStyle(Color.black)
                            )
                        
                    })
                    .popover(isPresented: $showCapacityPopover, content: {
                        HStack {
                            Picker("ml", selection: $selectedCapacityIndex) {
                                ForEach(0..<footerHomeViewModel.capacityOptions.count) {
                                    Text("\(footerHomeViewModel.capacityOptions[$0]) ml")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .onChange(of: selectedCapacityIndex) { _, newValue in
                                footerHomeViewModel.capacitySelected = Double(footerHomeViewModel.capacityOptions[newValue])
                            }
                        }
                        //                        .padding()
                        //                        .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2)
                        .presentationCompactAdaptation(.popover)
                    })
                }
                //                .toolbar {
                //                    ToolbarItemGroup(placement: .topBarTrailing) {
                //                        Button ("Done") {
                //                            isPresented = false
                //                            dismiss ()
                //                        }
                //                            .foregroundStyle(Color.red)
                //                    }
                //
                //                }
                
                
                .padding()
            }
            .navigationTitle("Água")
            
        }
        Button("Done") {
            isPresented = false
            dismiss ()
        }
        .foregroundStyle(Color.red)
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
