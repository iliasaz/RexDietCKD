//
//  DefaultFoods.swift
//  RexDiet
//
//  Created by Ilia Sazonov on 7/9/22.
//

import Foundation

let turkey = Food(name: "Turkey Thighs", servingSize: 348.0, calories: 637.0, protein: 83.0, fat: 33.0, phosphorus: 0.170, potassium: 0.95, sodium: 0.351, maxMass: 500.0, step: 10.0)
let sweetPotato = Food(name: "Sweet Potatos", servingSize: 114.0, calories: 103.0, protein: 2.3, fat: 0.2, phosphorus: 0.036, potassium: 0.542, sodium: 0.041, maxMass: 500.0)
let rice = Food(name: "White Rice", calories: 205.0/158.0, protein: 1.4/205.0, fat: 0.4/205.0, phosphorus: 0.035/87.0, potassium: 0.055/205.0, sodium: 0.0016/205.0, maxMass: 500.0)
let macaroni = Food(name: "Macaroni", servingSize: 120.0, calories: 190.0, protein: 7.0, fat: 1.1, phosphorus: 0.0, potassium: 0.053, sodium: 0.0012, maxMass: 500.0)
let greenBeans = Food(name: "Green Beans", servingSize: 125.0, calories: 44.0, protein: 2.4, fat: 0.3, phosphorus: 0.036, potassium: 0.183, sodium: 0.001, maxMass: 500.0)
let eggWhites = Food(name: "Egg Whiltes", servingSize: 33.0, calories: 17.0, protein: 3.6, fat: 0.1, phosphorus: 33.0*0.015/95.0, potassium: 0.054, sodium: 0.055, maxMass: 100)
let chickenThighs = Food (name: "Chicken Thighs", servingSize: 130.0, calories: 278.0, protein: 31.0, fat: 18.0, phosphorus: 130.0*0.150/85.0, potassium: 0.33, sodium: 0.226, maxMass: 500.0)
let coconutOil = Food(name: "Coconut Oil", servingSize: 14.0, calories: 121, protein: 0.0, fat: 13.0, phosphorus: 0.0, potassium: 0, sodium: 0, maxMass: 100)
let tripett = Food(name: "Chewy Tripett Wet", servingSize: 362.0, calories: 308.55, protein: 0.11*362.0, fat: 0.07*362.0, phosphorus: 362.0*0.012/100.0, potassium: 0, sodium: 0, maxMass: 500)
let proplan = Food(name: "Pro Plan Kidney Wet", servingSize: 377, calories: 483.00, protein: 377.0*0.038, fat: 377.0*0.055, phosphorus: 377.0*0.0015, potassium: 0, sodium: 377.0*0.0013, maxMass: 1000)
let kidneyCare = Food(name: "Hills Kidney Care Chicken", servingSize: 345.0, calories: 358.0, protein: 345.0*0.025, fat: 345.0*0.040, phosphorus: 345.0*0.002, potassium: 345.0*0.0037, sodium: 345.0*0.0019, maxMass: 1000)
let royalCaninRenalSupport = Food(name: "Royal Canin Renal Support", servingSize: 385.0, calories: 598.0, protein: 385.0*0.054, fat: 385.0*0.09, phosphorus: 385.0*0.0011, potassium: 385.0*0.0028, sodium: 385.0*0.0017, maxMass: 1000)
let cookie = Food(name: "Blue Health Bar", servingSize: 17.0, calories: 17.0*70.0, protein: 17.0*0.011*17.0, fat: 17.0*0.005*17.0, phosphorus: 0.0, potassium: 0.0, sodium: 0.0, maxMass: 5, uom: .pcs)
let peanutButter = Food(name: "Peanut Butter", servingSize: 32.0, calories: 190.0, protein: 8.0, fat: 16.0, phosphorus: 32.0*0.068/16.0, potassium: 32.0*0.04, sodium: 0.0, maxMass: 100)
let duckMeat = Food(name: "Duck Meat", servingSize: 140.0, calories: 472.0, protein: 27.0, fat: 40.0, phosphorus: 0.284, potassium: 0.286, sodium: 0.083, maxMass: 500)
let duckFat = Food(name: "Duck Fat", calories: 113.0/13.0, protein: 0.0, fat: 1.0, phosphorus: 0.0, potassium: 0.0, sodium: 0.0, maxMass: 50)
let lamb = Food(name: "Lamb Chops", servingSize: 85.0, calories: 250.0, protein: 21.0, fat: 18.0, phosphorus: 0.185, potassium: 0.264, sodium: 0.061, maxMass: 500.0)
let salmon = Food(name: "Salmon Steak", servingSize: 227.0, calories: 468.0, protein: 50.0, fat: 28.0, phosphorus: 227.0*0.215/85.0, potassium: 0.872, sodium: 0.138, maxMass: 500.0)

let defaultFoods = [royalCaninRenalSupport, kidneyCare, proplan, tripett, turkey,sweetPotato,rice,macaroni,greenBeans,eggWhites,chickenThighs, coconutOil, cookie, peanutButter, duckMeat, duckFat, lamb, salmon]
let savedFoodsKey = "SavedFoods"
