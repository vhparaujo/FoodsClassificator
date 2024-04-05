//
//  PerfilImageViewComponent.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftUI
import PhotosUI

struct PerfilImageViewComponent: View {
    
    @Binding var userPhoto: Data
    @State private var photosPickerItem: PhotosPickerItem?
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 2)
            .foregroundStyle(.verdeTitle)
            .overlay {
                PhotosPicker(selection: $photosPickerItem, matching: .images) {
                    if let uiImage = UIImage(data: userPhoto) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(.circle)
                    }
                   
                }
                .onChange(of: photosPickerItem) { _, _ in
                    Task {
                        if let photosPickerItem,
                           let data = try await photosPickerItem.loadTransferable(type: Data.self) {
                                userPhoto = data
                        }
                        photosPickerItem = nil
                    }
                }
                
            }
            
    }
}

#Preview {
    // Supondo que você tenha uma extensão que permita inicializar uma UIImage a partir de um recurso com o nome "labelPerfil"
    var photo: UIImage = UIImage(named: "labelPerfil")!

    // Converta a imagem em dados, por exemplo, em formato PNG
    guard let imageData = photo.pngData() else {
        fatalError("Não foi possível converter a imagem em dados.")
    }

    // Agora você pode passar os dados da imagem para o construtor do UIImage dentro de PerfilImageViewComponent
    return PerfilImageViewComponent(userPhoto: .constant(Data(imageData)))

}
