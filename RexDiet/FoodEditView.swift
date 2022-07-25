//
//  FoodEditView.swift
//  RexDiet
//
//  Created by Ilia Sazonov on 7/9/22.
//

import SwiftUI

struct FloatingTextField: View {
    let title: String
    let value: Binding<Double>

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.caption)
                .foregroundColor(Color(.placeholderText))
            TextField(title, value: value, format: .number)
                .keyboardType(.decimalPad)
        }
    }
}

struct FoodEditView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var foodValue: FoodValue
    @State private var isEditingPortion = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section("Name") {
                    TextField("Ingredient Name", text: $foodValue.food.name, prompt: Text("Ingredient name"))
                    Picker("Units", selection: $foodValue.food.uom) {
                        ForEach(UOM.allCases) {uom in
                            Text(uom.rawValue)
                        }
                    }
                }
                
                Section("Nutrition facts per serving") {
                    FloatingTextField(title: "Serving size", value: $foodValue.food.servingSize)
                    FloatingTextField(title: "Calories", value: $foodValue.food.calories)
                    FloatingTextField(title: "Protein", value: $foodValue.food.protein)
                    FloatingTextField(title: "Fat", value: $foodValue.food.fat)
                    FloatingTextField(title: "Phosphorus", value: $foodValue.food.phosphorus)
                    FloatingTextField(title: "Potassium", value: $foodValue.food.potassium)
                    FloatingTextField(title: "Sodium", value: $foodValue.food.sodium)
                }
                
                Section("Display Options") {
                    FloatingTextField(title: "Max per day", value: $foodValue.food.maxMass)
                    FloatingTextField(title: "Slider Step", value: $foodValue.food.step)
                }
            }
            
            Spacer()
        }
            .navigationBarTitle(foodValue.food.name)
    }
}

struct FoodEditView_Previews: PreviewProvider {
    static var previews: some View {
        FoodEditView(foodValue: .constant(FoodValue(food: sweetPotato, mass: 0.0)))
            .previewInterfaceOrientation(.portrait)
    }
}
