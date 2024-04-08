//
//  WaterRectangleComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 22/03/24.
//

import SwiftUI

struct WaterRectangleComponentHomeView: View {
    @Environment(FooterHomeViewModel.self) var footerHomeViewModel
    @Environment(\.dismiss) private var dismiss

    @State var isPresented = false
    @State private var showPopover: Bool = false
    
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        Button(action: {
            print("Ediçao abeta")
            isPresented = true
        }, label: {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(Color.verdeFundo)
                .overlay {
                    HStack {
                        VStack {
                            Text("Água")
                                .font(.system(size: 27))
                                .bold()
                                .foregroundStyle(Color.white)
                                .padding(.trailing)
                                .minimumScaleFactor(0.5)
                            
                            Text("\(footerHomeViewModel.waterIntakeTotalFormatted) / \(footerHomeViewModel.totalWaterInLiters, specifier: "%.2f")L")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundStyle(Color.white)
                                .padding(.trailing)
                                .minimumScaleFactor(0.5)
                            
                            HStack {
                                ForEach(0..<4) { index in
                                    Circle()
                                        .stroke(lineWidth: 2) // Desenha o contorno da bolinha
                                        .background(footerHomeViewModel.filledCircles > index ? Circle().fill(Color.white) : Circle().fill(Color.clear)) // Preenche se a condição for verdadeira
                                }
                            }
                        }
                        Spacer()
                        
                        Button(action: {
                            footerHomeViewModel.addWaterIntake()
                        }, label: {
                            footerHomeViewModel.isBottleSelected ?
                            Image("WaterBottle")
                                .resizable()
                                .scaledToFit()
                            :
                            Image("cup")
                                .resizable()
                                .scaledToFit()
                        })
                    }
                    .padding()
                    .sheet(isPresented: $isPresented, content: {
                        WaterModalComponentHomeView(isPresented: $isPresented)
                            .presentationDetents([.medium])
                        
                    })
                }
                .frame(height: height * 0.15)
        })
    }
    
}


#Preview {
    var footerHomeViewModel = FooterHomeViewModel()
    return HomeView()
        .environment(footerHomeViewModel)
    
}
