//
//  CalculoCaloriasOnBoarding.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 26/03/24.
//

import SwiftUI

struct CalculoCaloriasOnBoarding: View {
    @State private var gender = 0
    @State private var age = ""
    @State private var weight = ""
    @State private var height = ""
    @State private var activityLevel = 0
    
    let genders = ["Male", "Female"]
    let activityLevels = ["Sedentary", "Lightly Active", "Moderately Active", "Very Active", "Extremely Active"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    Picker("Gender", selection: $gender) {
                        ForEach(0 ..< genders.count) {
                            Text(self.genders[$0])
                        }
                    }
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                    TextField("Weight (kg)", text: $weight)
                        .keyboardType(.numberPad)
                    TextField("Height (cm)", text: $height)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Activity Level")) {
                    Picker("Activity Level", selection: $activityLevel) {
                        ForEach(0 ..< activityLevels.count) {
                            Text(self.activityLevels[$0])
                        }
                    }
                    .pickerStyle(.wheel)
                }
                
                Section(header: Text("Calories Needed Per Day")) {
                    Text("Calories: \(caloriesPerDay, specifier: "%.0f")")
                }
            }
            .navigationBarTitle("Calorie Calculator")
        }
    }
    
    var caloriesPerDay: Double {
        let genderFactor = gender == 0 ? 5 : -161
        let weight = Double(self.weight) ?? 0
        let height = Double(self.height) ?? 0
        let age = Double(self.age) ?? 0
        let activityMultiplier = [1.2, 1.375, 1.55, 1.725, 1.9][activityLevel]
        
        let bmr = (10 * weight) + (6.25 * height) - (5 * age) + Double(genderFactor)
        let calories = bmr * activityMultiplier
        return calories
    }
}


#Preview {
    CalculoCaloriasOnBoarding()
}
