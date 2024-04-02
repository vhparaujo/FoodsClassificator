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
    
    @State var litersSelected:Double = 2.0
    @State var milliliterSelected:Double = 0.0

    @State var capacitySelected = 200.0
    
    @State var waterIntakeTotal:Double = 0.0
    
    @State private var showPopover: Bool = false
    
    var body: some View {
        
        var totalWaterIntakeLiters: Double {
              let millilitersInLiters = milliliterSelected / 1000.0
              return litersSelected + millilitersInLiters
          }
        
        var waterIntakeTotalFormatted: String {
                return String(format: "%.1f", waterIntakeTotal / 1000.0)
            }

        // Calcula o total de água selecionada em ml
        var totalWaterSelectedInML: Double {
            (litersSelected * 1000) + milliliterSelected
        }
        
        // Calcula a porcentagem de água consumida em relação ao total selecionado
        var waterIntakePercentage: Double {
            guard totalWaterSelectedInML > 0 else { return 0 }
            return (waterIntakeTotal / totalWaterSelectedInML)
        }
        
        // Calcula quantas bolinhas preencher baseado na porcentagem de água consumida
        var filledCircles: Int {
            let percentage = waterIntakePercentage
            return Int(percentage * 4) // Como temos 4 bolinhas
        }

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
                                .minimumScaleFactor(0.5)
                            
                            Text("\(waterIntakeTotalFormatted) / \(totalWaterIntakeLiters, specifier: "%.1f")L")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundStyle(Color.white)
                                .padding(.trailing)
                                .minimumScaleFactor(0.5)

                            
                            
                            HStack {
                                ForEach(0..<4) { index in
                                    Circle()
                                        .stroke(lineWidth: 2) // Desenha o contorno da bolinha
                                        .background(filledCircles > index ? Circle().fill(Color.white) : Circle().fill(Color.clear)) // Preenche se a condição for verdadeira
                                        .frame(width: 20, height: 20)
                                }

                            }
                        }
                        
                        Spacer()

                        
                        
                        Button(action: {
                            waterIntakeTotal += Double(capacitySelected)
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
