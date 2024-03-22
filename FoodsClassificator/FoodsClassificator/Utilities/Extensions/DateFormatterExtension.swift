//
//  DateFormatterExtension.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 21/03/24.
//

import SwiftUI

extension DateFormatter {
    static let dataFormatada: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = /*.current*/Locale(identifier: "pt_BR")
        formatter.dateStyle = .long
        return formatter
    }()

    static let horaFormatada: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateStyle = .long
        return formatter
    }()
}
