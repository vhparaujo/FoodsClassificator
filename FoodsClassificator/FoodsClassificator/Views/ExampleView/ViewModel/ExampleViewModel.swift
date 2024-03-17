//
//  ExampleViewModel.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 17/03/24.
//

import SwiftUI

@Observable class ExampleViewModel {
    
    private var timer: Timer?
    var textIsValid: Bool = false
    var showButton: Bool = false
    
    var count: Int = 0 {
        didSet {
            checkButtonVisibility()
        }
    }
    
    var textFieldText: String = "" {
        didSet {
            validateTextField()
        }
    }
    
    init() {
        setUpTimer()
    }
    
    func checkButtonVisibility() {
        showButton = textIsValid && count >= 10
    }
    
    func validateTextField() {
        textIsValid = textFieldText.count > 3
    }
    
    func setUpTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            self.count += 1
        }
    }
    
}
