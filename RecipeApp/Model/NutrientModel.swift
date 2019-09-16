//
//  NutrientModel.swift
//  RecipeApp
//
//  Created by Avital Miskella on 30/8/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import Foundation

//Types of units of food
enum Unit:String {
    case g = "Grams"
    case mg = "Miligrams"
    case L = "Litres"
    case ml = "Mililitres"
    case ts = "Teaspoon"
    case tbs = "Tablespoon"
    case cups = "Cups"
    case other = "Unit"
}

//Class conatining properties of a nutrient
class Nutrient{

    private var name:String
    private var amount:Float
    private var unitName:Unit
    
    init(name:String, amount:Float, unitName:Unit){
        self.name = name
        self.amount = amount
        self.unitName = unitName
    }
    
    func presentationForm() -> (name:String, unit:String) {
        let name = self.name
        let unit = "\(self.amount)\(self.unitName)"
        return (name:name , unit:unit)
    }

}
