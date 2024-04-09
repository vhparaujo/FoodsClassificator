//
//  FoodItemCell.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 05/04/24.
//

import SwiftUI

struct FoodItemCell: View {
    var showImage: Bool
    var image: Image?
    let title: String
    let weight: String
    let calories: String
    var onAdd: () -> Void
    
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        HStack {
            if showImage, let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.leading, 10)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title2)
                Text(weight)
                    .font(.subheadline)
                Text(calories)
                    .font(.subheadline)
            }
            .padding(.leading, (showImage && image != nil) ? 10 : 20)

            Spacer()
            
            Button(action: onAdd) {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: screenWidth * 0.1, height: screenWidth * 0.1)
                    .foregroundColor(.black)
            }
            .padding(.trailing, 20)
        }
        .frame(width: screenWidth * 0.9, height: screenHeight * 0.12)
        .background(Color.laranjaMacros)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct FoodItemCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FoodItemCell(
                showImage: true,
                image: Image(systemName: "photo"), // Usando um ícone de sistema para o exemplo de preview
                title: "Batata frita",
                weight: "100 gramas",
                calories: "300 Cal",
                onAdd: { print("Adicionar") }
            )
            
            FoodItemCell(
                showImage: false,
                image: nil, // Nenhuma imagem fornecida
                title: "Batata cozida",
                weight: "100 gramas",
                calories: "80 Cal",
                onAdd: { print("Adicionar") }
            )
        }
        .previewLayout(.sizeThatFits)
    }
}

