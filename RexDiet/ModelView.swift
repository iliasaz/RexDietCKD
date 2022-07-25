//
//  ModelView.swift
//  RexDiet
//
//  Created by Ilia on 4/9/22.
//

import Foundation
import Combine

// Units of Measurement
enum UOM: String, CaseIterable, Identifiable, Codable, Hashable {
case gram = "g", pcs = "pcs"
    var id: Self {self}
}

// This extension is to automatically save a Published variabe in UserDefaults
private var cancellableSet: Set<AnyCancellable> = []

extension Published where Value: Codable {
    init(wrappedValue defaultValue: Value, key: String) {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                let value = try JSONDecoder().decode(Value.self, from: data)
                self.init(initialValue: value)
            } catch {
                print("Error while decoding user data")
                self.init(initialValue: defaultValue)
            }
        } else {
            self.init(initialValue: defaultValue)
        }

        projectedValue
            .sink { val in
                do {
                    let data = try JSONEncoder().encode(val)
                    UserDefaults.standard.set(data, forKey: key)
                } catch {
                    print("Error while decoding user data")
                }
            }
            .store(in: &cancellableSet)
    }
}

extension Range where Bound == Double {
    static func * (left: Range<Double>, right: Bound) -> Range<Double> {
        return (left.lowerBound * right) ..< (left.upperBound * right)
    }
    
    static func * (left: Bound, right: Range) -> Range {
        return right * left
    }
}

// Safe ranges, per 1000 calories
struct Constants {
    static let proteinRange = 31.0..<41.1
    static let fatRange = 40.0..<62.1
    static let phosphorusRange = 0.5..<0.9
    static let potassiumRange = 1.1..<2.4
    static let sodiumRange = 0.4..<1.2
}


// Ingredients
struct Food: Identifiable, Equatable, Codable, Hashable {
    var id = UUID()
    var name: String
    var servingSize: Double = 1.0
    var calories: Double
    var protein: Double
    var fat: Double
    var phosphorus: Double
    var potassium: Double
    var sodium: Double
    var maxMass: Double
    var step: Double = 1.0
    var uom: UOM = .gram
}

// Ingredients when a part of a menu
struct FoodValue: Identifiable, Codable, Hashable {
    var id = UUID()
    var food: Food
    var mass: Double
}


class ModelView: ObservableObject {
    @Published(key: "ration") var ration: [FoodValue] = defaultFoods.map { FoodValue(food: $0, mass: 0.0) }
    
    var calories: Double {
        ration.reduce(0, { (res, foodValue) in return res + foodValue.mass * foodValue.food.calories / foodValue.food.servingSize } )
    }
    
    var proteins: Double {
        ration.reduce(0, { (res, foodValue) in return res + foodValue.mass * foodValue.food.protein / foodValue.food.servingSize } )
    }
    
    var fats: Double {
        ration.reduce(0, { (res, foodValue) in return res + foodValue.mass * foodValue.food.fat / foodValue.food.servingSize } )
    }
    
    var phosphorus: Double {
        ration.reduce(0, { (res, foodValue) in return res + foodValue.mass * foodValue.food.phosphorus / foodValue.food.servingSize } )
    }
    
    var potassiums: Double {
        ration.reduce(0, { (res, foodValue) in return res + foodValue.mass * foodValue.food.potassium / foodValue.food.servingSize } )
    }
    
    var sodiums: Double {
        ration.reduce(0, { (res, foodValue) in return res + foodValue.mass * foodValue.food.sodium / foodValue.food.servingSize } )
    }
    
    func deleteFood(at offsets: IndexSet) {
        ration.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        ration.move(fromOffsets: source, toOffset: destination)
    }
    
    func newFood() {
        let fv = FoodValue(food: Food(name: "New Ingredient", servingSize: 100.0, calories: 0.0, protein: 0.0, fat: 0.0, phosphorus: 0.0, potassium: 0.0, sodium: 0.0, maxMass: 500.0, step: 1.0, uom: .gram), mass: 0.0)
        ration.insert(fv, at: 0)
    }
    
    func resetFoods() {
        ration.removeAll()
        for food in defaultFoods {
            ration.append(FoodValue(food: food, mass: 0.0))
        }
    }
}
