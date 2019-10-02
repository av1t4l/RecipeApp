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
    case g
    case mg
    case L
    case ml
    case ts
    case tbs
    case cups
    case kcal
    case other
}

//Class conatining properties of a nutrient
class Nutrient{

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
    
    //add subnutrient by values
    func addSubNutrient(name:String, amount:Float, unitName:Unit){
        let temp = Nutrient(name:name, amount:amount, unitName:unitName)
        temp.subNutrient = true
        subNutrients.append(temp)
    }
    // add subnutrient by already created object
    func addSubNutrientObject(nutrient:Nutrient){
        subNutrients.append(nutrient)
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


