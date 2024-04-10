//
//  ContentViewModel.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 24/02/24.
//

import UIKit
import Vision
import CoreML

class ImagePredictor: ObservableObject {
    
    static let shared = ImagePredictor()
    private var model: VNCoreMLModel?
    @Published var modelResults:[String] = []
    
    init() {
        setupModel()
    }
    
    private func setupModel() {
        do {
            let configuration = MLModelConfiguration()
            let coreMLModel = try FoodDetection(configuration: configuration).model
            model = try VNCoreMLModel(for: coreMLModel)
            print("Model successfully configured for Vision.")
        } catch {
            print("Failed to load ML Model for Vision: \(error)")
        }
    }
    

    // Função para realizar previsões, suportando tanto classificação quanto detecção de objetos
    func detectObjects(in pixelBuffer: CVPixelBuffer, completion: @escaping ([VNRecognizedObjectObservation]) -> Void) {
        do {
//            let configuration = MLModelConfiguration()
//            let model = try VNCoreMLModel(for: FoodDetection(configuration: configuration).model)
            
            guard let model = model else{
                return
            }
            
            let request = VNCoreMLRequest(model: model) { (request, error) in
                guard let results = request.results as? [VNRecognizedObjectObservation] else {
                    print("Falha ao obter resultados: \(error?.localizedDescription ?? "Erro desconhecido")")
                    return
                }
                
                DispatchQueue.main.async {
                    self.modelResults = self.collectDetectionCodes(results)
                    completion(results)
                }
            }
            
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            try handler.perform([request])
        } catch {
            print("Falha ao carregar o modelo Core ML ou ao realizar a detecção: \(error)")
        }
    }

    private func collectDetectionCodes(_ results: [VNRecognizedObjectObservation]) -> [String] {
        var detectionCodes: [String] = []
        for result in results {
            for label in result.labels where label.confidence > 0.5 {
                if let code = FoodItem.findCodeByName(label.identifier) {
                    detectionCodes.append(code)
                    print("\(label.identifier) - Código: \(code), Confiança: \(label.confidence)")
                } else {
                    print("\(label.identifier) - Nada encontrado")
                }
            }
        }
        print("Detection: \(detectionCodes)")
        return detectionCodes
    }


}
