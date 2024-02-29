//
//  ContentView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 24/02/24.
//

import SwiftUI
import CoreML
import PhotosUI
import Vision

struct ContentView: View {
    
    @State private var showPicker = false
    @State private var showTrue = false
    @State private var showCamera = false
    @State private var photoPicker: PhotosPickerItem?
    @State private var imageSelected: UIImage?
    @State private var imagePredictor = ImagePredictor()
    
    @State private var predictionText: String = "Nenhuma previsão ainda."
    
    let predictsQTD = 3
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                VStack {
                    
                    if let image = imageSelected {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .padding()
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.gray)
                            .scaledToFit()
                            .padding()
                    }
                    
                    Text(predictionText)
                        .padding()
                        .font(.title2)
                    
                    Button("Select Image") {
                        showTrue.toggle()
                    }
                    .padding(10)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    .confirmationDialog("Select", isPresented: $showTrue, titleVisibility: .visible) {
                        Button("Camera") {
                            self.showCamera.toggle()
                        }
                        Button("Gallery") {
                            self.showPicker.toggle()
                        }
                        
                    }.photosPicker(isPresented: $showPicker, selection: $photoPicker)
                    
                    Button("Classify Image"){
                        if let image = imageSelected{
                            classifyImage(image)
                        }
                    }
                    .padding(10)
                    .foregroundStyle(.white)
                    .background(.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }
                
                .navigationTitle("Foods")
                
                .fullScreenCover(isPresented: self.$showCamera) {
                    CameraView(selectedImage: self.$imageSelected, isPresented: $showCamera, sourceType: .camera)
                }
                
                .onChange(of: photoPicker) { _, newImage in
                    Task {
                        do {
                            if let imageData = try await newImage?.loadTransferable(type: Data.self), let loadedImage = UIImage(data: imageData) {
                                imageSelected = loadedImage
                                predictionText = ""
                            }
                        } catch {
                            print("Error loading image: \(error.localizedDescription)")
                        }
                    }
                }
                
            }
        }
        
    }
    
    private func classifyImage(_ image: UIImage) {
        do {
            try imagePredictor.makePredictions(for: image) { predictions, observations in
                self.imagePredictionHandler(predictions, observations: observations!)
            }
        } catch {
            DispatchQueue.main.async {
                self.predictionText = "Erro ao fazer previsões: \(error.localizedDescription)"
            }
        }
    }
    
    private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?, observations: [VNRecognizedObjectObservation]) {
        DispatchQueue.main.async {
            // Verifica se há previsões
            guard let predictions = predictions, !predictions.isEmpty else {
                self.predictionText = "Sem previsões."
                return
            }
            
            // Utiliza a função `formatPredictions` para formatar todas as previsões desejadas
            let formattedPredictions = self.formatPredictions(predictions)
            
            // Atualiza o texto de previsão com os resultados da classificação
            self.predictionText = formattedPredictions.joined(separator: "\n")
            
            // Assume-se que `imageSelected` é a imagem atual selecionada pelo usuário
            if let imageWithBoundingBoxes = self.drawBoundingBoxes(on: self.imageSelected!, for: observations) {
                self.imageSelected = imageWithBoundingBoxes
            }
        }
    }
    
    private func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
        return predictions.map { "\($0.classification) - \($0.confidencePercentage)%" }
    }
    
    func drawBoundingBoxes(on image: UIImage, for observations: [VNRecognizedObjectObservation]) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: image.size)
        let newImage = renderer.image { context in
            // Desenha a imagem original
            image.draw(at: CGPoint.zero)
            
            // Configurações para o retângulo
            let strokeColor = UIColor.red
            strokeColor.setStroke()
            
            for observation in observations {
                let boundingBox = observation.boundingBox
                let width = boundingBox.width * image.size.width
                let height = boundingBox.height * image.size.height
                let size = CGSize(width: width, height: height)
                let origin = CGPoint(x: boundingBox.minX * image.size.width, y: (1 - boundingBox.minY - boundingBox.height) * image.size.height)
                let rectangle = CGRect(origin: origin, size: size)
                
                // Calcula a área do boundingBox
                let area = width * height
                print("Área do BoundingBox: \(area) pixels quadrados")
                
                // Desenha o retângulo
                let path = UIBezierPath(rect: rectangle)
                path.lineWidth = 2
                path.stroke()
            }
        }
        return newImage
    }

//    func drawBoundingBoxes(on image: UIImage, for observations: [VNRecognizedObjectObservation]) -> UIImage? {
//        let renderer = UIGraphicsImageRenderer(size: image.size)
//        let newImage = renderer.image { context in
//            // Desenha a imagem original
//            image.draw(at: CGPoint.zero)
//            
//            // Configurações para o retângulo
//            let strokeColor = UIColor.red
//            strokeColor.setStroke()
//            
//            for observation in observations {
//                let boundingBox = observation.boundingBox
//                let size = CGSize(width: boundingBox.width * image.size.width, height: boundingBox.height * image.size.height)
//                let origin = CGPoint(x: boundingBox.minX * image.size.width, y: (1 - boundingBox.minY - boundingBox.height) * image.size.height)
//                let rectangle = CGRect(origin: origin, size: size)
//                
//                // Desenha o retângulo
//                let path = UIBezierPath(rect: rectangle)
//                path.lineWidth = 2
//                path.stroke()
//            }
//        }
//        return newImage
//    }
    
    
}


#Preview {
    ContentView()
}
