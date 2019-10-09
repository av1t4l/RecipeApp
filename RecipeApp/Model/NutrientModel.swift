//
//  NutrientModel.swift
//  RecipeApp
//
//  Created by Avital Miskella on 30/8/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import Foundation

//Types of units of food
enum Unit:String, CaseIterable {
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
public class Nutrient: NSObject{

    private var name:String
    private var nickname:String = ""
    private var amount:Float
    private var staticAmount:Float
    private var unitName:Unit
    private var subNutrients = [Nutrient]()
    private var subNutrient:Bool = false

    init(name:String, amount:Float, unitName:Unit){
        self.name = name
        self.amount = amount
        self.staticAmount = amount
        self.unitName = unitName
    }
    
    func presentationForm() -> (name:String, nickname:String, unit:String) {
        let name = self.name
        let unit = "\(self.amount)\(self.unitName)"
        return (name:name, nickname:self.nickname , unit:unit)
    }

    func addSubNutrient(name:String, amount:Float, unitName:Unit){
        let temp = Nutrient(name:name, amount:amount, unitName:unitName)
        temp.subNutrient = true
        subNutrients.append(temp)
    }
    
    func addNickname(name:String){
        self.nickname = name
    }
    
    func hasSubNutrients() -> Bool{
        if self.subNutrients.isEmpty{
            return false
        }
        else{
            return true
        }
    }
    
    func getSubNutrients() -> [Nutrient]{
        return self.subNutrients
    }
    
    func isSubNutrient() -> Bool{
        return subNutrient
    }
    
    func updateAmount(factor: Int, recipeServeSize: Int){
        //divide by usual servingsize and amount to get the usual amount per one serve
        amount = staticAmount / Float(recipeServeSize)
        
        //multipy one serving's amount by the factor from user
        amount = amount * Float(factor)
    }
}
