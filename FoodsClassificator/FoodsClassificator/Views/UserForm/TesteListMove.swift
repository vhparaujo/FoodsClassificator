//
//  TesteListMove.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 12/04/24.
//

import SwiftUI

struct TesteListMove: View {
    
    @State var array = ["tsss", "wee", "ferr", "fvdgrre"]
    @State var isEditing = false
    
    var body: some View {
        
        List {
            ForEach(array, id: \.self) { text in
                HStack {
                    Text(text)
                        .tint(.verdeTitle)
                        .font(.headline)
                    Spacer()
                }
                .padding()
                .background(.verdeFundo)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .listRowSeparator(.hidden)
            }
            .onDelete(perform: delete)
            .onMove(perform: move)
        }
        
        .listRowSpacing(-11)
        .listStyle(.inset)
        .toolbar {
           EditButton()
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        array.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        array.move(fromOffsets: source, toOffset: destination)
    }
}


#Preview {
    NavigationStack {
        TesteListMove()
    }
}
