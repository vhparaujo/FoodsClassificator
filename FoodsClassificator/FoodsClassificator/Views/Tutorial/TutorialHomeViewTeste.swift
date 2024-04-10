////
////  TutorialHomeView.swift
////  FoodsClassificator
////
////  Created by Gabriel Ribeiro Noronha on 04/04/24.
////
//
//import SwiftUI
//
//struct TutorialHomeViewTeste: View {
//    var body: some View {
//        
//        TabView {
//            GeometryReader { /*geometry in*/
//                let safeArea = $0.safeAreaInsets
//                HStack {
//                    VStack {
//                        VStack {
//                            RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
//                                .foregroundStyle(Color.red)
//                                .showCase(order: 2,
//                                          title: "ELEMENTO 3",
//                                          cornerRadius: 10,
//                                          style: .continuous)
//                            
//                            RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
//                                .foregroundStyle(Color.green)
//                                .showCase(order: 3,
//                                          title: "ELEMENTO 4",
//                                          cornerRadius: 10,
//                                          style: .continuous)
//                            
//                            RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
//                                .foregroundStyle(Color.blue)
//                                .showCase(order: 4,
//                                          title: "ELEMENTO 5",
//                                          cornerRadius: 10,
//                                          style: .continuous)
//                            
//                            RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
//                                .foregroundStyle(Color.yellow)
//                                .showCase(order: 5,
//                                          title: "ELEMENTO 6",
//                                          cornerRadius: 10,
//                                          style: .continuous)
//                        }
//                    }
//                    VStack {
//                        RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
//                            .foregroundStyle(Color.red)
//                            .showCase(order: 6,
//                                      title: "ELEMENTO 7",
//                                      cornerRadius: 10,
//                                      style: .continuous)
//                        RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
//                            .foregroundStyle(Color.green)
//                            .showCase(order: 7,
//                                      title: "ELEMENTO 8",
//                                      cornerRadius: 10,
//                                      style: .continuous)
//                        
//                        RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
//                            .foregroundStyle(Color.blue)
//                            .showCase(order: 8,
//                                      title: "ELEMENTO 9",
//                                      cornerRadius: 10,
//                                      style: .continuous)
//                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 10))
//                            .foregroundStyle(Color.yellow)
//                            .showCase(order: 9,
//                                      title: "ELEMENTO 10",
//                                      cornerRadius: 10,
//                                      style: .continuous)
//                    }
//                }
//                .overlay(alignment: .top, content: {
//                    Rectangle()
//                        .fill(.ultraThinMaterial)
//                        .frame(height: safeArea.top)
//                })
//                .ignoresSafeArea()
//                .overlay(alignment: .topTrailing){
//                    VStack{
//                        Button{
//                            
//                        } label: {
//                            Image(systemName: "pencil.circle")
//                                .foregroundStyle(Color.white)
//                                .padding(10)
//                                .background{
//                                    RoundedRectangle(cornerRadius: 10,
//                                                     style: .continuous)
//                                    .fill(.black)
//                                }
//                        }
//                        .showCase(order: 0,
//                                  title: "ELEMENTO 1",
//                                  cornerRadius: 10,
//                                  style: .continuous)
//                        
//                        
//                        Spacer()
//                        
//                        Button{
//                            
//                        } label: {
//                            Image(systemName: "heart.fill")
//                                .foregroundStyle(Color.red)
//                                .padding(10)
//                                .background{
//                                    RoundedRectangle(cornerRadius: 10,
//                                                     style: .continuous)
//                                    .fill(.green)
//                                }
//                        }
//                        .showCase(order: 1,
//                                  title: "ELEMENTO 2",
//                                  cornerRadius: 10,
//                                  style: .continuous)
//                        
//                    }
//                    .padding(15)
//                }
//            }
//            .tabItem {
//                Image(systemName: "square.and.arrow.up")
//                Text("Aba1")
//
//            }
//            
//            .toolbarBackground(.visible, for: .tabBar)
//            .toolbarBackground(.ultraThinMaterial, for: .tabBar)
//            
//            Text("")
//                .tabItem {
//                    Image(systemName: "square.and.arrow.up")
//                    Text("Aba2")
//                }
//            
//            Text("")
//                .tabItem {
//                    Image(systemName: "square.and.arrow.up")
//                    Text("Aba3")
//                }
//        }
//        .overlay(alignment: .bottom, content: {
//            HStack (spacing: 0){
//                Circle()
//                    .foregroundStyle(Color.clear)
//                    .frame(width: 45, height: 45)
//                    .frame(maxWidth: .infinity)
//                Circle()
//                    .foregroundStyle(Color.clear)
//                    .frame(width: 45, height: 45)
//               
//                    .frame(maxWidth: .infinity)
//                Circle()
//                    .foregroundStyle(Color.clear)
//                    .frame(width: 45, height: 45)
//                    .frame(maxWidth: .infinity)
//
//            }
//        ///disable the click on it
//            .allowsHitTesting(false)
//        })
//        /// Call  This Modifier on top of the   Current View, also it must be called once
//        .modifier(ShowCaseRoot(showStartPopover: $showStartPopover, showHighlights: true, onFinished: {
//            print("Finished Tutorial")
//        }))
//        
//    }
//}
//
//#Preview {
//    TutorialHomeViewTeste()
//}
