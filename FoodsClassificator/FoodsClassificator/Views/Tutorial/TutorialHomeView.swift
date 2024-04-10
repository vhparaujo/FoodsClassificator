//
//  TutorialHomeView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 10/04/24.
//

import SwiftUI

enum PopoverType {
    case standard
    case custom 
    case vazio // Adicione mais tipos conforme necessário
}

struct TutorialHomeView: View {
    @State private var navigationTarget: NavigationTarget?
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var background = BackgroundShapeHeaderHomeView()
    var viewModel =  HomeViewModel()

    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State var showStartPopover = false
    
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
                        .showCase(order: 2,
                                  title: "Acompanhe seu crescimento, participe de desafios para evoluir e celebre suas vitórias! A ofensiva é ativada quando você atinge sua meta diária de água e registra pelo menos uma refeição.",
                                  cornerRadius: 10,
                                  style: .continuous)
                    }.padding()
                        
                    
                    ZStack {
                        HStack {
                            VStack {
                                
                                MacrosComponentHomeView(macroType: "Carboidratos",
                                                        backgroundColor: Color.amareloCarboidratos, macro:  viewModel.totalMeals?.macros.carbohydrates ?? 0)
                                .padding(.vertical)
                                
                                MacrosComponentHomeView(macroType: "Gorduras",
                                                        backgroundColor: Color.rosaGorduras, macro:  viewModel.totalMeals?.macros.fats ?? 0)
                                .padding(.vertical)
                            }
                            Spacer()
                            
                            VStack {
                                MacrosComponentHomeView(macroType: "Proteínas",
                                                        backgroundColor: Color.rosaProteinas, macro:  viewModel.totalMeals?.macros.proteins ?? 0)
                                .padding(.vertical)
                                
                                MacrosComponentHomeView(macroType: "Fibras",
                                                        backgroundColor: Color.amareloFibras, macro:  viewModel.totalMeals?.macros.fibers ?? 0)
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
                            }
                            .padding(.horizontal)
                                .offset(y:40)
                                .padding(.horizontal)
                        }
                        .frame(width: screenWidth * 0.5)
                        .showCase(order: 3,
                                  title: "Defina suas calorias e acompanhe seu objetivo diário, além de ver como está progredindo!",
                                  cornerRadius: 10,
                                  style: .continuous)
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
                    
                    ZStack {
                        Rectangle()
                            .foregroundStyle(Color.clear)
                            .allowsHitTesting(false)
                            .showCase(order: 4,
                                      title: "",
                                      cornerRadius: 0,
                                      style: .circular,
                                      popoverType: .vazio)
                            .frame(width: 0, height: 0)
                            .alert(isPresented: $showStartPopover) {
                                Alert(
                                    title: Text("Definir calorias"),
                                    message: Text("Precisamos de algumas informações para melhorar sua experiência definindo as calorias, levará 5 minutos. "),
                                    primaryButton: .default(Text("Melhorar Experiência"), action: {
                                        navigationTarget = .improveExperience
                                    }),
                                    secondaryButton: .cancel(Text("Talvez Mais Tarde"), action: {
                                        navigationTarget = .maybeLater
                                    })
                                )
                            }
                        NavigationLink(destination: FormsPage1(), isActive: .constant(navigationTarget == .improveExperience)) { EmptyView() }
                        NavigationLink(destination: HomeView(), isActive: .constant(navigationTarget == .maybeLater)) { EmptyView() }
                        
                        
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
                                }
                                
                                .padding()
                                
                            })
                            .showCase(order: 0,
                                      title: "Registre suas refeições facilmente! Use a câmera para alimentos ou código de barras, ou apenas pesquise. Veja as calorias e nutrientes de cada refeição enquanto registra sua alimentação.",
                                      cornerRadius: 180,
                                      style: .continuous)
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
                    .padding(.bottom)
                    
                    
                    
//                        Spacer()
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
                        .showCase(order: 1,
                                  title: "Lembre-se de se hidratar! Personalize seu recipiente de água e a meta diária. Quando terminar sua garrafinha, não se esqueça de registrar!",
                                  cornerRadius: 10,
                                  style: .continuous)
                        .background(.laranjaBrilhante)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.horizontal, 60)
                        .frame(height: screenHeight * 0.15)
                        
                    
                }
                .background(
                    Image("backgroundHome")
                        .resizable()
                        .scaledToFill())
            }
//            .alert
            .modifier(ShowCaseRoot( showStartPopover: $showStartPopover, showHighlights: true, onFinished: {
                print("Finished Tutorial")
            }))
            
            
        }
    }
}
// Enum para representar o destino da navegação
enum NavigationTarget {
    case improveExperience, maybeLater
}



#Preview {
    TutorialHomeView()
}
