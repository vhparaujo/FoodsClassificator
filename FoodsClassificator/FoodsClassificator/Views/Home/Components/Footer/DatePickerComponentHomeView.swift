//
//  DatePickerComponentHomeView.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 21/03/24.
//

import SwiftUI

struct DatePickerComponentHomeView: View {
    
    @State var selectedDate = Date()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        // Put your own design here
        HStack(spacing: 2) {
            Image(systemName: "calendar")
            Text(" \(dateString)")
                .font(.system(size: 13, weight: .semibold))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .foregroundColor(.black)
        .background(
            RoundedRectangle(cornerRadius: 15,
                             style: .continuous)
            .foregroundColor(.laranjaBrilhante))
        
        // Put the actual DataPicker here with overlay
        .overlay {
            DatePicker(selection: $selectedDate, displayedComponents: .date) {}
                .labelsHidden()
                .contentShape(Rectangle())
                .opacity(0.011)
        }
        
    }
    
    private var dateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        let currentDate = Date()
        
        if Calendar.current.isDate(selectedDate, inSameDayAs: currentDate) {
            return "Hoje"
        } else {
            return selectedDate.formatted(.dateTime.day().month())
            
        }
    }
}


#Preview {
    DatePickerComponentHomeView()
}
