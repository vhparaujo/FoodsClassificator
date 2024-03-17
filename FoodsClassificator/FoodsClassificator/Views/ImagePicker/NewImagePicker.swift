//
//  CameraModel.swift
//  ClassificacaoFrutasTeste
//
//  Created by Gabriel Ribeiro Noronha on 01/03/24.
//

import Foundation
import SwiftUI
import Vision

//MARK: camera consiguration in swiftui
// Estrutura para representar o NewImagePicker
struct NewImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage?
    var sourceType: UIImagePickerController.SourceType
    var completion: ([VNRecognizedObjectObservation]) -> Void
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<NewImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    //teste
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<NewImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: NewImagePicker
        
        init(_ parent: NewImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
                if let pixelBuffer = parent.convertUIImageToCVPixelBuffer(image) {
                    parent.detectObjects(in: pixelBuffer) { [self] results in
                        // Chame o completion handler com os resultados
                        parent.completion(results)
                    }
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
    
    //Converte a imagem repeciba pra um PixeBuffer para que possa ser lida pelo MLModel
    func convertUIImageToCVPixelBuffer(_ image: UIImage) -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard status == kCVReturnSuccess else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context?.translateBy(x: 0, y: image.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
    
    
    
    //Core ML para realizar a detecção
    // Modifique a assinatura do método detectObjects para incluir um completion handler
    func detectObjects(in pixelBuffer: CVPixelBuffer, completion: @escaping ([VNRecognizedObjectObservation]) -> Void) {
        do {
            let configuration = MLModelConfiguration()
            let model = try VNCoreMLModel(for: FoodDetection(configuration: configuration).model)
            
            let request = VNCoreMLRequest(model: model) { (request, error) in
                guard let results = request.results as? [VNRecognizedObjectObservation] else {
                    print("Falha ao obter resultados: \(error?.localizedDescription ?? "Erro desconhecido")")
                    return
                }
                
                DispatchQueue.main.async {
                    completion(results)
                }
            }
            
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            try handler.perform([request])
        } catch {
            print("Falha ao carregar o modelo Core ML ou ao realizar a detecção: \(error)")
        }
    }

    
}
