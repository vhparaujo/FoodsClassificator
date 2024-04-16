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
    @State private var showView:Bool = true
    
    @Environment(\.dismiss) var dismiss
    @State private var navigationTarget: NavigationTarget?
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var background = BackgroundShapeHeaderHomeView()
    var viewModel =  HomeViewModel()
    
    //    var perfil = PerfilViewModel()
    
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State var showStartPopover = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HomeView()
                
                Rectangle()
                    .showCase(order: 4,
                              title: "",
                              cornerRadius: 0,
                              style: .continuous,
                              popoverType: .vazio)
                    .frame(width: 0.00001, height: 0.00001)
                    .foregroundStyle(Color.black.opacity(0.5))
                    .alert(isPresented: $showStartPopover) {
                        Alert(
                            title: Text("Definir calorias"),
                            message: Text("Precisamos de algumas informações para melhorar sua experiência definindo as calorias, levará 5 minutos. "),
                            primaryButton: .default(Text("Melhorar Experiência"), action: {
                                navigationTarget = .improveExperience
                            }),
                            secondaryButton: .cancel(Text("Talvez Mais Tarde"), action: {
                                showView = false
                            })
                        )
                    }
                
                VStack{
                    //MARK: HEADER VIEW
                    VStack {
                        HStack {
                            Text("Olá, Fulano!")
                                .font(.title)
                                .foregroundStyle(.clear)
                            Spacer()
                            
                            ZStack{
                                HStack{
                                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                }
                                .frame(width: 84, height: 45)
                                .padding(.horizontal)
                                .background(Color.clear)
                                
                            }
                            .showCase(order: 2,
                                      title: "Acompanhe seu crescimento, participe de desafios para evoluir e celebre suas vitórias! A ofensiva é ativada quando você atinge sua meta diária de água e registra pelo menos uma refeição.",
                                      cornerRadius: 10,
                                      style: .continuous)
                        }
                        .padding()
                        
                        ZStack {
                            
                            HStack {
                                VStack {
                                    RoundedRectangle(cornerRadius: 17, style: .continuous)
                                        .frame(width: 150, height: 60)
                                        .foregroundStyle(.clear)
                                        .padding(.vertical)
                                    
                                    RoundedRectangle(cornerRadius: 17, style: .continuous)
                                        .frame(width: 150, height: 60)
                                        .foregroundStyle(.clear)
                                        .padding(.vertical)
                                }
                                Spacer()
                                
                                VStack {
                                    RoundedRectangle(cornerRadius: 17, style: .continuous)
                                        .frame(width: 150, height: 60)
                                        .foregroundStyle(.clear)
                                        .padding(.vertical)
                                    
                                    RoundedRectangle(cornerRadius: 17, style: .continuous)
                                        .frame(width: 150, height: 60)
                                        .foregroundStyle(.clear)
                                        .padding(.vertical)
                                }
                                
                            }
                            .padding()
                                
                                
                                
                                
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .frame(width: screenWidth * 0.5,  height: screenHeight * 0.33)
                                    .showCase(order: 3,
                                              title: "Defina suas calorias e acompanhe seu objetivo diário, além de ver como está progredindo!",
                                              cornerRadius: 10,
                                              style: .continuous)
                            
                        }
                        
                    }
                    
                    Spacer()
                    
                    //MARK: ----------FOOTERVIEW-------------------------------------------------------
                    VStack {
                        
                        NavigationLink(destination: FormsPage1(), isActive: .constant(navigationTarget == .improveExperience)) { EmptyView() }
                        
                        
                        Circle()
                            .showCase(order: 0,
                                      title: "Registre suas refeições facilmente! Use a câmera para alimentos ou código de barras, ou apenas pesquise. Veja as calorias e nutrientes de cada refeição enquanto registra sua alimentação.",
                                      cornerRadius: 180,
                                      style: .continuous
                                      ,scale: 1.15)
                        //                            .frame(height: screenHeight * 0.3)
                        
                        
                        
                        RoundedRectangle(cornerRadius: 25.0)
                            .showCase(order: 1,
                                      title: "Lembre-se de se hidratar! Personalize seu recipiente de água e a meta diária. Quando terminar sua garrafinha, não se esqueça de registrar!",
                                      cornerRadius: 10,
                                      style: .continuous)
                            .padding(.horizontal, 65)
                            .frame(height: screenHeight * 0.15)
                            .padding(.top, 30)
                        
                        
                    }
                }
                .foregroundStyle(Color.clear)
                
                
            }
            .modifier(ShowCaseRoot( showStartPopover: $showStartPopover, showHighlights: true, onFinished: {
                print("Finished Tutorial")}, showView: $showView))
        }
    }
}
// Enum para representar o destino da navegação
enum NavigationTarget {
    case improveExperience
}
