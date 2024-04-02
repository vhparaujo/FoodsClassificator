//
//  WaterRectangleComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 22/03/24.
//

import SwiftUI

struct WaterRectangleComponentHomeView: View {
    @State var isPresented = false
    
    @State var isCupSelected = false
    @State var isBottleSelected = true
    
    @State var litersSelected = 2
    @State var milliliterSelected = 00
    @State var capacitySelected = 200
    
    @State var aguaTotal = 0.0
    
    @State private var showPopover: Bool = false
    
    var body: some View {
        
        Button(action: {
            print("EDITAR")
            isPresented = true
        }, label: {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(Color.laranjaFundoHome)
                .frame(width: 200, height: 120)
                .overlay {
                    HStack {
                        VStack {
                            Text("Água")
                                .font(.system(size: 27))
                                .bold()
                                .foregroundStyle(Color.white)
                                .padding(.trailing)
                            
                            Text("\(displayText) / \(litersSelected),\(milliliterSelected)L")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundStyle(Color.white)
                                .padding(.trailing)
                            
                            
                            HStack {
                                ForEach(0..<4) { _ in
                                    Circle()
                                }
                            }
                        }
                        
                        Spacer()
                        
                        var displayText: String {
                            if aguaTotal >= 1000 {
                                let litros = Int(aguaTotal / 1000) // Calcula o número de litros
                                let decimais = String(format: "%.2f", (aguaTotal / 1000)) // Calcula a parte decimal dos litros
                                return "\(decimais)" // Retorna a string formatada
                            } else {
                                return "\(Int(aguaTotal))" // Retorna a quantidade de água em mililitros
                            }
                        }
                        
                        Button(action: {
                            aguaTotal += Double(capacitySelected)
                        }, label: {
                            isBottleSelected ?
                            Image("WaterBottle")
                                .resizable()
                                .scaledToFit()
                            :
                            Image("cup")
                                .resizable()
                                .scaledToFit()
                            
                        }
                               
                        )
                    }
                    .padding()
                    .sheet(isPresented: $isPresented, content: {
                        WaterModalComponentHomeView(litrosSelecionados: $litersSelected,
                                                    mililiterSelected: $milliliterSelected,
                                                    capacidadeSelecionada: $capacitySelected,
                                                    isCupSelected: $isCupSelected,
                                                    isBottleSelected: $isBottleSelected,
                                                    isPresented: $isPresented,
                                                    showPopover: $showPopover)
                        .presentationDetents([.medium])
                        
                    })
                }
        })
    }
}

#Preview {
    HomeView()
}
