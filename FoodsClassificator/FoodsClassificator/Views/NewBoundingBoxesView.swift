//
//  BoundingBoxView.swift
//  ClassificacaoFrutasTeste
//
//  Created by Gabriel Ribeiro Noronha on 01/03/24.
//
import SwiftUI
import Vision

struct NewBoundingBoxesView: View {
    var image: UIImage
    var observations: [VNRecognizedObjectObservation]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                
                ForEach(observations, id: \.uuid) { observation in
                    let boundingBox = observation.boundingBox
                    
                    // Convertendo boundingBox para coordenadas da view
                    let rect = CGRect(x: boundingBox.minX * geometry.size.width,
                                      y: (1 - boundingBox.minY - boundingBox.height) * geometry.size.height,
                                      width: boundingBox.width * geometry.size.width,
                                      height: boundingBox.height * geometry.size.height)
                    
                    Rectangle()
                        .path(in: rect)
                        .stroke(Color.red, lineWidth: 2)
                        .opacity(0.3)
                }
            }
        }
    }
}


