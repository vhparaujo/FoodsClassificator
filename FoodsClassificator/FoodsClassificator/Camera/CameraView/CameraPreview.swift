//
//  CameraPreview.swift
//  FoodsClassificator
//
//  Created by Arthur Dos Reis on 26/03/24.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var cameraController: CameraController
    @Binding var isOverlayVisible: Bool
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        let previewLayer = cameraController.getPreviewLayer()
        previewLayer.frame = view.frame
        
        view.layer.addSublayer(previewLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if isOverlayVisible {
            cameraController.setupCameraOverlay()
        } else {
            cameraController.removeCameraOverlay()
        }
    }
}

