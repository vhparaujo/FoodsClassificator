//
//  WaterRectangleComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 22/03/24.
//

import SwiftUI

struct WaterRectangleComponentHomeView: View {
    @Environment(FooterHomeViewModel.self) var footerHomeViewModel : FooterHomeViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State var isPresented = false
    @State private var showPopover: Bool = false
    
    let height = UIScreen.main.bounds.height
    let width = UIScreen.main.bounds.width
    
    var body: some View {
        Button(action: {
            isPresented = true
        }, label: {
            
            HStack {
                
                VStack(alignment: .leading) {
                    Text("Água")
                        .font(.title)
//                        .fontWeight(.semibold)
                        .foregroundStyle(Color.black)
                        .padding(.trailing)
                        .minimumScaleFactor(0.5)
                    
                    Text("\(footerHomeViewModel.waterIntakeTotalFormatted) / \(footerHomeViewModel.totalWaterInLiters, specifier: "%.2f")L")
                        .font(.title3)
                        .foregroundStyle(Color.black)
                        .padding(.trailing)
                        .minimumScaleFactor(0.5)
                    
                    Spacer()
                    
                    HStack {
                        ForEach(0..<4) { index in
                            Circle()
                                .stroke(lineWidth: 1)
                                .foregroundStyle(.black)// Desenha o contorno da bolinha
                                .background(footerHomeViewModel.filledCircles > index ?
                                            Circle()
                                    .fill(Color.white) : Circle().fill(Color.white.opacity(0.3)))
                                .frame(width: width * 0.04)
                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    footerHomeViewModel.addWaterIntake()
                }, label: {
                    footerHomeViewModel.isBottleSelected ?
                    Image("garrafaPretaHome")
                        .resizable()
                        .scaledToFit()
                        .tint(.black)
                    :
                    Image("cup")
                        .resizable()
                        .scaledToFit()
                        .tint(.black)
                })
            }
            .padding()
            .background(.laranjaBrilhante)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal, 60)
            .sheet(isPresented: $isPresented, content: {
                WaterModalComponentHomeView(isPresented: $isPresented)
                    .presentationDetents([.medium])
                    .menuIndicator(.visible)
            })
            .frame(height: height * 0.15)
        })
    }
    
}


#Preview {
    var footerHomeViewModel = FooterHomeViewModel()
    return HomeView()
        .environment(footerHomeViewModel)
}
