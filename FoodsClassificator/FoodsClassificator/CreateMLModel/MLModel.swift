//
//  ViewModel.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 24/02/24.
//

import Foundation
import Combine
import Vision
import VisionKit

//class ViewModel: ObservableObject {
//    
//    func classifyImage(image: UIImage) {
//        
//        guard let ciImage = CIImage(image: image) else { return }
//        
//        let handler = VNImageRequestHandler(ciImage: ciImage)
//        
//        let request = VNClassifyImageRequest { request, error in
//            
//            if let result = request.results as? [VNClassificationObservation] {
//                print("classification \(result.first?.identifier) confidence \(result.first?.confidence)")
//            }
//        }
//        
//        do {
//            try handler.perform([request])
//        } catch {
//            print(error.localizedDescription)
//        }
// 
//    }
//    
//    
//    func foodClassifyImage(image: UIImage){
//        let resizeImage = image.resize(size: CGSize(width: 224, height: 224))
//        
//        guard let buffer = resizeImage?.getBuffer() else { return }
//        
//        do {
//            let model = try AlimentosClassificator(configuration: MLModelConfiguration())
//            let prediction = try model.prediction(image: buffer)
//            print("Food Classification = \(prediction.target)")
//            
//        } catch let error {
//            print("Error - \(error.localizedDescription)")
//        }
//        
//    }
//    
//}


//
//func classifyImage() {
//    
//    let currentImageName = self.photo
//    
//    guard let image = UIImage(named: currentImageName),
//          let resizedImage = image.resize(size: CGSize(width: 299, height: 299)),
//          let buffer = resizedImage.getBuffer() else { return
//    }
//    
//    do {
//        
//        let config = MLModelConfiguration()
//        let model = try AlimentosClassificator_2(configuration: config)
//        
//        let output = try? model.prediction(image: buffer)
//        
//        if let output = output {
//            self.classificationLabel = output.target
//        }
//    
//    } catch {
//        print(error.localizedDescription)
//    }
//    
//}

class ImagePredictor {
    static func createImageClassifier() -> VNCoreMLModel {
        let defaultConfig = MLModelConfiguration()
        
        // My CreateML Model
        let imageClassifierWrapper = try? FoodDetection(configuration: defaultConfig)

        guard let imageClassifier = imageClassifierWrapper else {
            fatalError("App failed to create an image classifier model instance.")
        }
        
        let imageClassifierModel = imageClassifier.model
        
        guard let imageClassifierVisionModel = try? VNCoreMLModel(for: imageClassifierModel) else {
            fatalError("App failed to create a `VNCoreMLModel` instance.")
        }
        
        return imageClassifierVisionModel
    }

    /// A common image classifier instance that all Image Predictor instances use to generate predictions.
    ///
    /// Share one ``VNCoreMLModel`` instance --- for each Core ML model file --- across the app,
    /// since each can be expensive in time and resources.
    private static let imageClassifier = createImageClassifier()

    /// Stores a classification name and confidence for an image classifier's prediction.
    /// - Tag: Prediction
    struct Prediction {
        /// The name of the object or scene the image classifier recognizes in an image.
        let classification: String

        /// The image classifier's confidence as a percentage string.
        ///
        /// The prediction string doesn't include the % symbol in the string.
        let confidencePercentage: String
    }

    /// The function signature the caller must provide as a completion handler.
    typealias ImagePredictionHandler = (_ predictions: [Prediction]?) -> Void

    /// A dictionary of prediction handler functions, each keyed by its Vision request.
    private var predictionHandlers = [VNRequest: ImagePredictionHandler]()

    /// Generates a new request instance that uses the Image Predictor's image classifier model.

    
    private func createImageClassificationRequest() -> VNImageBasedRequest {
        let imageClassificationRequest = VNCoreMLRequest(model: ImagePredictor.imageClassifier, completionHandler: visionRequestHandler)
        // Se seu modelo suporta detecção de objetos, isso é suficiente. Caso contrário, você precisaria de um request específico para isso.
        imageClassificationRequest.imageCropAndScaleOption = .centerCrop
        return imageClassificationRequest
    }
//-----------
    /// Generates an image classification prediction for a photo.
    /// - Parameter photo: An image, typically of an object or a scene.
    /// - Tag: makePredictions
    /// 
    func makePredictions(for photo: UIImage, completionHandler: @escaping ([Prediction]?, [VNRecognizedObjectObservation]?) -> Void) throws {
        // Converte UIImage para CGImage e prepara o handler de requisição de imagem
        guard let photoCGImage = photo.cgImage else {
            print("Não foi possível converter UIImage em CGImage.")
            return
        }
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(photo.imageOrientation.rawValue))!
        let handler = VNImageRequestHandler(cgImage: photoCGImage, orientation: orientation)

        // Prepara a requisição VNCoreMLRequest para o modelo que suporta detecção de objetos
        let request = VNCoreMLRequest(model: ImagePredictor.imageClassifier) { request, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Erro ao processar a requisição: \(error.localizedDescription)")
                    completionHandler(nil, nil)
                    return
                }

                // Extrai as observações do tipo VNRecognizedObjectObservation
                let objectObservations = request.results as? [VNRecognizedObjectObservation]

                // Aqui você pode processar as classificações das observações, se necessário
                let predictions = objectObservations?.map { observation -> Prediction in
                    // Assumindo que você tem uma maneira de extrair a classificação mais provável
                    let topClassification = observation.labels.first!.identifier
                    let confidence = observation.labels.first!.confidence
                    return Prediction(classification: topClassification, confidencePercentage: String(format: "%.2f%", confidence * 100))
                }

                completionHandler(predictions, objectObservations)
            }
        }

        // Executa a requisição
        try handler.perform([request])
    }

    /// The completion handler method that Vision calls when it completes a request.
    /// - Parameters:
    ///   - request: A Vision request.
    ///   - error: An error if the request produced an error; otherwise `nil`.
    ///
    ///   The method checks for errors and validates the request's results.
    /// - Tag: visionRequestHandler
    private func visionRequestHandler(_ request: VNRequest, error: Error?) {
        // Remove the caller's handler from the dictionary and keep a reference to it.
        guard let predictionHandler = predictionHandlers.removeValue(forKey: request) else {
            fatalError("Every request must have a prediction handler.")
        }

        // Start with a `nil` value in case there's a problem.
        var predictions: [Prediction]? = nil

        // Call the client's completion handler after the method returns.
        defer {
            // Send the predictions back to the client.
            predictionHandler(predictions)
        }

        // Check for an error first.
        if let error = error {
            print("Vision image classification error...\n\n\(error.localizedDescription)")
            return
        }

        // Check that the results aren't `nil`.
        if request.results == nil {
            print("Vision request had no results.")
            return
        }

        // Cast the request's results as an `VNClassificationObservation` array.
        guard let observations = request.results as? [VNClassificationObservation] else {
            // Image classifiers, like MobileNet, only produce classification observations.
            // However, other Core ML model types can produce other observations.
            // For example, a style transfer model produces `VNPixelBufferObservation` instances.
            print("VNRequest produced the wrong result type: \(type(of: request.results)).")
            return
        }

        // Create a prediction array from the observations.
        predictions = observations.map { observation in
            // Convert each observation into an `ImagePredictor.Prediction` instance.
            Prediction(classification: observation.identifier,
                       confidencePercentage: observation.confidencePercentageString)
        }
    }
}

extension VNClassificationObservation {
    var confidencePercentageString: String {
        let percentage = confidence * 100

        switch percentage {
            case 100.0...:
                return "100%"
            case 10.0..<100.0:
                return String(format: "%2.1f", percentage)
            case 1.0..<10.0:
                return String(format: "%2.1f", percentage)
            case ..<1.0:
                return String(format: "%1.2f", percentage)
            default:
                return String(format: "%2.1f", percentage)
        }
    }
}
