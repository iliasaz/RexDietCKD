//
//  ContentView.swift
//  RexDiet
//
//  Created by Ilia on 4/1/22.
//

import SwiftUI

struct FoodSliderView: View {
    @State private var isEditing: Bool = false
    @Binding var foodValue: FoodValue
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("\(foodValue.food.name)")
                Spacer()
                Text(foodValue.mass.rounded(), format: .number )
                Text(foodValue.food.uom.rawValue) //.frame(width: 30, alignment: .trailing)
            }
            .foregroundColor(isEditing ? .red : .blue)
            
            Slider(value: $foodValue.mass, in: 0...$foodValue.food.maxMass.wrappedValue, step: foodValue.food.step, onEditingChanged: {
                editing in isEditing = editing
            })
        }
    }
}

struct FoodSliderView_OLD: View {
    @State private var isEditing: Bool = false
    @Binding var foodValue: FoodValue
    
    var body: some View {
        HStack {
            Text("\(foodValue.food.name)")
                .foregroundColor(.blue)
                .frame(width: 100.0, alignment: .leading)
            Slider(value: $foodValue.mass, in: 0...$foodValue.food.maxMass.wrappedValue, step: foodValue.food.step, onEditingChanged: {
                editing in isEditing = editing
            })
            HStack {
                Text(foodValue.mass.rounded(), format: .number )
                Text(foodValue.food.uom.rawValue).frame(width: 30, alignment: .leading)
            }
                .foregroundColor(isEditing ? .red : .blue)
        }
    }
}

struct ReportComponent: View {
    var componentName: String
    var range: Range<Double>
//    var calories: Double
    var actualValue: Double
    
    var body: some View {
        HStack {
            Text(componentName)
                .frame(width: 150, alignment: .leading)
            Text("\(range.lowerBound, specifier: "%.2f") - \(range.upperBound, specifier: "%.2f")")
            Spacer()
            Text("\(actualValue, specifier: "%.2f")")
                .foregroundColor(range.contains(actualValue) ? .green : .red)
        }
    }
}

struct ContentView: View {
    @AppStorage("weight") private var weightLB: Double = 70.0
    private var targetCalories: Double { pow(weightLB*0.453, 0.75) * 70.0 * (neutered ? 1.6 : 1.8) }
    @State private var isSliderEditing = false
    @State private var editingFood: Binding<FoodValue>?
    @AppStorage("isNeutered") private var neutered = true
    @ObservedObject var mv: ModelView = ModelView()
    @Environment(\.editMode) private var isListEditing
    @State private var listSelection: UUID?
    @State private var showingResetAlert = false
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                VStack(alignment: .leading) {
                    Slider(value: $weightLB, in: 10.0...200.0, onEditingChanged: {
                        editing in isSliderEditing = editing
                    })
                    
                    HStack {
                        Spacer()
                        Text("weight \(Int(weightLB)) lb")
                            .foregroundColor(isSliderEditing ? .red : .blue)
                        Spacer()
                        Toggle("Neutered?", isOn: $neutered).frame(width: 140)
                    }
                    
                    reportView

                    List(selection: $listSelection) {
                        ForEach ($mv.ration) { foodValue in
                            NavigationLink(destination: FoodEditView(foodValue: foodValue), tag: foodValue.id, selection: $listSelection) {
                                FoodSliderView(foodValue: foodValue)
                                    .padding(.vertical, 5)
                                    .id(foodValue.id)
                            }
                        }
                        .onDelete(perform: mv.deleteFood)
                        .onMove(perform: mv.move)
                    }
                    .listStyle(.plain)
                    
                    Spacer()
                }
                .navigationTitle("Your 🐕 CKD Diet")
                .padding(.horizontal)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: { showingResetAlert = true } ) { Text("Reset") }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {
                            mv.newFood()
                            proxy.scrollTo(mv.ration[0].id, anchor: .top)
                            listSelection = mv.ration[0].id
                        }) {
                            Text("Add")
                        }
                    }
                    ToolbarItem(placement: .automatic) {
                        EditButton()
                    }
                }
                    .alert(isPresented:$showingResetAlert) {
                        Alert(
                            title: Text("Are you sure you want to Reset?"),
                            message: Text("This will delete all added and modified ingredients and reset your menu to 0"),
                            primaryButton: .destructive(Text("Reset")) {
                                mv.resetFoods()
                            },
                            secondaryButton: .cancel()
                        )
                    }
            } // scrollviewreader
        }
    }
    
    var reportView: some View {
        VStack {
            HStack {
                Text("Daily Values").fontWeight(.bold).frame(width: 150, alignment: .leading)
                Text("Target").fontWeight(.bold)
                Spacer()
                Text("Actual").fontWeight(.bold)
            }
            .padding(.vertical, 0.5)
            
            HStack {
                Text("Calories")
                    .frame(width: 150, alignment: .leading)
                Text(targetCalories.rounded(), format: .number)
                Spacer()
                Text(mv.calories.rounded(), format: .number)
                    .foregroundColor(mv.calories > targetCalories * 0.90 ? .green : .red)
            }
            
            // Default ranges are given per 1000 calories, so need to adjust them for the actual calorie content
            ReportComponent(componentName: "Proteins", range: Constants.proteinRange * (mv.calories / 1000.0), actualValue: mv.proteins)
            ReportComponent(componentName: "Fats", range: Constants.fatRange * (mv.calories / 1000.0), actualValue: mv.fats)
            ReportComponent(componentName: "Phosphorus", range: Constants.phosphorusRange * (mv.calories / 1000.0), actualValue: mv.phosphorus)
            ReportComponent(componentName: "Potassium", range: Constants.potassiumRange * (mv.calories / 1000.0), actualValue: mv.potassiums)
            ReportComponent(componentName: "Sodium", range: Constants.sodiumRange * (mv.calories / 1000.0), actualValue: mv.sodiums)
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
