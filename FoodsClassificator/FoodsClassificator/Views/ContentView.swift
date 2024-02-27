//
//  ContentView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 24/02/24.
//

import SwiftUI
import CoreML
import PhotosUI

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
            try imagePredictor.makePredictions(for: image, completionHandler: imagePredictionHandler)
        } catch {
            DispatchQueue.main.async {
                self.predictionText = "Vision não conseguiu fazer uma previsão...\n\n\(error.localizedDescription)"
            }
        }
    }
    
    private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
        DispatchQueue.main.async {
            guard let predictions = predictions, !predictions.isEmpty else {
                self.predictionText = "Sem previsões. (Verifique o log do console.)"
                return
            }
            let formattedPredictions = self.formatPredictions(predictions)
            self.predictionText = formattedPredictions.joined(separator: "\n")
        }
    }
    
    
    private func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
        let topPredictions: [String] = predictions.prefix(predictsQTD).map { prediction in
//            "\(prediction.classification)"
            "\(prediction.classification) - \(prediction.confidencePercentage)%"
        }
        return topPredictions
    }
}


#Preview {
    ContentView()
}
