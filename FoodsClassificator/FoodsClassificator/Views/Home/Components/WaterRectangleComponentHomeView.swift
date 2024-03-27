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
    
    @State var litrosSelecionados = 2
    @State var capacidadeSelecionada = 50
    
    @State var aguaTotal = 0.0
    
    
    
    var body: some View {
        //        ZStack {
        RoundedRectangle(cornerRadius: 25)
            .foregroundStyle(Color.laranjaFundoHome)
            .frame(width: 300, height: 100)
            .padding()
            .overlay {
                VStack {
                    HStack {
                        Text("Água")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundStyle(Color.white)
                            .padding(.horizontal)
                        Spacer()
                        var displayText: String {
                            if aguaTotal >= 1000 {
                                let litros = Int(aguaTotal / 1000) // Calcula o número de litros
                                let decimais = String(format: "%.2f", (aguaTotal / 1000)) // Calcula a parte decimal dos litros
                                return "\(decimais) L" // Retorna a string formatada
                            } else {
                                return "\(Int(aguaTotal))ml" // Retorna a quantidade de água em mililitros
                            }
                        }
                        
                        Text("\(displayText) / \(litrosSelecionados)L")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundStyle(Color.white)
                        
                        Button(action: {
                            print("EDITAR")
                            isPresented = true
                        }, label: {
                            Image(systemName: "pencil")
                                .font(.title)
                                .foregroundStyle(Color.white)
                        })
                    }
                    .padding(.horizontal)
                    .sheet(isPresented: $isPresented, content: {
                        WaterModalComponentHomeView(litrosSelecionados: $litrosSelecionados,
                                                    capacidadeSelecionada: $capacidadeSelecionada,
                                                    isCupSelected: $isCupSelected,
                                                    isBottleSelected: $isBottleSelected,
                                                    isPresented: $isPresented)
                        .presentationDetents([.medium])
                        
                    })
                    
                    HStack{
                        
                        ForEach(0..<4) { _ in
                            Button(action: {
                                aguaTotal += Double(capacidadeSelecionada)
                            }, label: {
                                isBottleSelected ?
                                Image("waterbottle")
                                    .resizable().frame(width: 20, height: 50)
                                :
                                Image("cup")
                                    .resizable().frame(width: 30, height: 50)
                                
                            })
                            .padding(.horizontal)
                            
                        }
                        
                    }
                }
                .padding()
                
            }
        
        //        }
    }
}

#Preview {
    HomeView()
}
