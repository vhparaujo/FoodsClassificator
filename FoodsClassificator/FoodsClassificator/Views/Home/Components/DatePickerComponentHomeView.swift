//
//  DatePickerComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 21/03/24.
//

import SwiftUI

struct DatePickerComponentHomeView: View {
    @State private var viewModel = HomeViewModel()
    @State  var selectedDate = Date()
    
    var body: some View {
        
        DatePicker("", selection: $selectedDate, in: Date()...,
                   displayedComponents: .date)
        .datePickerStyle(.compact).background(Color.orange)
        .labelsHidden()
        .padding()
    }
}

#Preview {
    DatePickerComponentHomeView()
}
