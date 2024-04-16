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
    
    @State var selectedItems: Set<String> = [] // Conjunto para armazenar os itens selecionados
    
    var body: some View {
        
        List(selection: $selectedItems) {
            Section {
                ForEach(array, id: \.self) { text in
                    
//                    Button {
//                       print(selectedItems)
//                    } label: {
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
            
//                }
                .onDelete(perform: delete)
                .onMove(perform: move)
                
            }
            .listRowBackground(Color.verdeFundo)
        }
        
        .listRowSpacing(10)
        .listStyle(.insetGrouped)
        
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
    
//    func toggleSelection(for item: String) {
//        if selectedItems.contains(item) {
//            selectedItems.remove(item)
//        } else {
//            selectedItems.insert(item)
//        }
//    }
    
}


#Preview {
    NavigationStack {
        TesteListMove()
    }
}
