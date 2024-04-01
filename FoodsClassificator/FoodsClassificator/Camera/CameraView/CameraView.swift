//
//  CameraView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 24/02/24.
//

import SwiftUI

struct CameraView: View {
    
    @StateObject var cameraManager = CameraController()
    @State var controlBolt:Bool = false
    @State var controlButton:Bool = false
    @State var controlBarCodeMask:Bool = false
    
    var body: some View {
        
        ZStack{
            
            CameraPreview(cameraController: cameraManager, isOverlayVisible: $controlBarCodeMask)
                .edgesIgnoringSafeArea(.all)
                .onAppear(perform: {
                    cameraManager.startRunning()
                })
            
            
            VStack{
                
                ZStack{
                    Rectangle()
                        .fill(Color.black)
                        .opacity(controlBarCodeMask ? 0.0 : 0.5)
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: UIScreen.main.bounds.height * 0.10)
                    
                    VStack{
                        Spacer()
                        HStack{
                            Button{
                                print("Apertou X")
                            }label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .tint(Color.white)
                                    .frame(width: 23, height: 23)
                            }
                            
                            Spacer()
                            
                            Button{
                                controlBolt.toggle()
                                controlBolt ? cameraManager.enableTorch():cameraManager.disableTorch()
                                
                            }label: {
                                
                                Image(systemName: "bolt.square")
                                    .resizable()
                                    .tint(controlBolt ? Color.yellow:Color.white)
                                    .frame(width: 28, height: 28)
                                
                                
                            }
                            
                        }
                        .padding(.horizontal)
                        
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.08)
                    
                    
                }
                
                Spacer()
                
                ZStack{
                    
                    Rectangle()
                        .fill(Color.black)
                        .opacity(controlBarCodeMask ? 0.0 : 0.5)
                        .frame(height: UIScreen.main.bounds.height*0.20)
                        .edgesIgnoringSafeArea(.bottom)
                    
                    
                    Spacer()
                    
                    if !controlBarCodeMask{
                        Button{
                            print("Apertou Camera")
                        }label: {
                            ZStack{
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 60, height: 60)
                                Circle()
                                    .stroke(Color.white, lineWidth: 4)
                                    .frame(width: 70, height: 70)
                            }
                        }
                    }
                    
                    HStack{
                        Spacer()
                        
                        Button {
                            controlButton.toggle()
                            controlBarCodeMask.toggle()
                        } label: {
                            ZStack{
                                Image(systemName: controlButton ? "camera" : "barcode.viewfinder")
                                    .resizable()
                                    .frame(width: controlButton ? 30 : 30, height: 30)
                                    .tint(Color.white)
                                Circle()
                                    .fill(Color.gray)
                                    .opacity(0.5)
                                    .frame(width: 55, height: 55)
                            }
                        }
                    }
                    .padding()
                }
            }
            .edgesIgnoringSafeArea(.all)
            .statusBar(hidden: cameraManager.isStatusBarHidden)
            .onDisappear{
                cameraManager.stopRunning()
            }
        }
    }
}

#Preview {
    CameraView()
}
