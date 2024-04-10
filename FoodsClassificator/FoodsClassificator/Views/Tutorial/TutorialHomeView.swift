//
//  TutorialHomeView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 10/04/24.
//

import SwiftUI

struct TutorialHomeView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var background = BackgroundShapeHeaderHomeView()
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            //            let safeArea = $0.safeAreaInsets
            VStack{
                VStack {
                    HStack {
                        Text("Olá, Fulano!")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.verdeTitle)
                        Spacer()
                        ZStack{
                            
                            HStack{
                                Text("20")
                                    .font(.callout)
                                    .bold()
                                    .foregroundStyle(Color.verdeTitle)
                                Image("fireSymbolHome")
                                    .foregroundStyle(.black)
                                
                                Spacer()
                            }
                            .frame(width: 80, height: 29)
                            .padding(.horizontal)
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.verdeTitle, lineWidth: 1)
                            )
                            
                            Circle()
                                .stroke(lineWidth: 2)
                                .foregroundStyle(.verdeTitle)
                                .overlay {
                                    Image("labelPerfil")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(.circle)
                                }
                                .frame(width: 45, height: 45)
                                .offset(x: 35)
                        }
                    }.padding()
                    
                    ZStack {
                        HStack {
                            VStack {
                                
                                MacrosComponentHomeView(macroType: "Carboidratos",
                                                        backgroundColor: Color.amareloCarboidratos)
                                .padding(.vertical)
                                
                                MacrosComponentHomeView(macroType: "Gorduras",
                                                        backgroundColor: Color.rosaGorduras)
                                .padding(.vertical)
                            }
                            Spacer()
                            
                            VStack {
                                MacrosComponentHomeView(macroType: "Proteínas",
                                                        backgroundColor: Color.rosaProteinas)
                                .padding(.vertical)
                                
                                MacrosComponentHomeView(macroType: "Fibras",
                                                        backgroundColor: Color.amareloFibras)
                                .padding(.vertical)
                            }
                            
                        }
                        .padding(.bottom)
                        .padding(.horizontal)
                        
                        VStack {
                            HStack {
                                ZStack {
                                    Image("mamaoHome")
                                        .resizable()
                                        .scaledToFit()
                                        .offset(y: -60)
                                    Circle()
                                        .foregroundStyle(Color.verdeFundo)
                                    Circle()
                                        .trim(from: 0.12, to: 0.88)
                                        .stroke(style: StrokeStyle(lineWidth: 23, lineCap: .round))
                                        .rotationEffect(.degrees(-270))
                                        .foregroundStyle(.verdeTitle)
                                    
                                    Circle()
                                        .trim(from: 0.12, to: 0.88)                    .stroke(style: StrokeStyle(lineWidth: 19, lineCap: .round))
                                        .rotationEffect(.degrees(-270))
                                        .foregroundStyle(Color.white)
                                        .opacity(0.8)
                                    
                                    Circle()
                                        .trim(from: 0.12, to: 0.70)
                                        .stroke(style: StrokeStyle(lineWidth: 14, lineCap: .round))
                                        .rotationEffect(.degrees(-270))
                                        .foregroundStyle(.verdeTitle)
                                    
                                    VStack{
                                        Text("Restam")
                                            .font(.title2)
                                            .foregroundStyle(.verdeTitle)
                                            .bold()
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.5)
                                            .offset(y: 15)
                                        
                                        Text("2000")
                                            .font(.title)
                                            .bold()
                                            .foregroundStyle(.verdeTitle)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.5)
                                            .offset(y: 10)
                                        
                                        Text("Calorias")
                                            .font(.headline)
                                            .foregroundStyle(.verdeTitle)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.5)
                                            .offset(y: 30)
                                    }
                                    
                                }
                            }.padding(.horizontal)
                                .offset(y:40)
                                .padding(.horizontal)
                        }.frame(width: screenWidth * 0.5)
                    }
                }
                .background(
                    background.path(in: CGRect(x: 0, y: 0,
                                               width: geometry.size.width,
                                               height: geometry.size.height * 0.5))
                    .foregroundStyle(.verdeFundo)
                    .ignoresSafeArea(edges: .all))
                .padding(.bottom, -20)
                
                //MARK: ----------FOOTERVIEW-------------------------------------------------------
                VStack{
                    HStack {
                        Spacer()
                        DatePickerComponentHomeView()
                            .padding(.trailing)
                    }
                    HStack {
                        VStack{
                            ZStack{
                                ZStack {
                                    Circle()
                                        .foregroundStyle(.laranjaBrilhante)
                                        .overlay(content: {
                                                VStack {
                                                    Spacer()
                                                    Text("Café da Manha")
                                                        .foregroundStyle(.black)
                                                        .font(.largeTitle)
                                                        .minimumScaleFactor(0.5)
                                                        .multilineTextAlignment(.center) // Alinhamento do texto ao centro
                                                        .padding(.horizontal) // Adiciona um preenchimento horizontal
                                                    
                                                    Spacer()
                                                    
                                                    Image(systemName: "plus")
                                                        .foregroundStyle(.black)
                                                        .font(.title)
                                                        .minimumScaleFactor(0.3)
                                                    
                                                    Spacer()
                                                }.padding()
                                            
                                        })
                                    
                                        .overlay {
                                            Circle()
                                                .stroke(lineWidth: 10)
                                                .foregroundStyle(.laranjaBrilhante)
                                        }
                                        .overlay {
                                            Circle()
                                                .stroke(lineWidth: 9)
                                                .foregroundStyle(.windowBackground)
                                        }
                                }
                            }
                        }
                    }.padding(.bottom)
                    
                    HStack {
                        Spacer()
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Água")
                                    .font(.title)
                                //                        .fontWeight(.semibold)
                                    .foregroundStyle(Color.black)
                                    .padding(.trailing)
                                    .minimumScaleFactor(0.5)
                                
                                Text("1.5 / 2.0L")
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
                                            .background(3 > index ?
                                                        Circle()
                                                .fill(Color.white) : Circle().fill(Color.white.opacity(0.3)))
                                            .frame(width: screenWidth * 0.04)
                                    }
                                }
                            }
                            
                            Spacer()
                            
                            Image("garrafaPretaHome")
                                .resizable()
                                .scaledToFit()
                                .tint(.black)
                        }
                        .padding()
                        .background(.laranjaBrilhante)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.horizontal, 60)
                        .frame(height: screenHeight * 0.15)
                        Spacer()
                    }
                    
                }
                .background(
                    Image("backgroundHome")
                        .resizable()
                        .scaledToFill())
            }
        }
    }
}

#Preview {
    TutorialHomeView()
}
