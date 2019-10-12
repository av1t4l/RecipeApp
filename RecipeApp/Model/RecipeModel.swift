//
//  RecipeModel.swift
//  RecipeApp
//
//  Created by Avital Miskella on 30/8/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import Foundation

/** Enum outlining the meal type catagories **/
enum MealType:String, CaseIterable{
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case dessert = "Dessert"
    case snack = "Snack"
    case crowd = "Crowd Pleaser"
}

/** Enum outlining the Dietary Reqs catagories **/
enum DietaryReq:String{
    case gf = "Gluten Free"
    case lf = "Lactose Free"
    case vego = "Vegatarian"
    case vegan = "Vegan"
    case FODMAP = "Low FODMAP"
}

/** Struct for creating a cooking time **/
struct Time{
    var cookingTime:Int
    var cookTimeUnit:String

    init(time:Int, unit:String){
        self.cookingTime = time
        self.cookTimeUnit = unit
    }
    
    func timeString() -> String{
        return "\(self.cookingTime)\(self.cookTimeUnit)"
    }
}

/** Enum outlining the difficulty levels **/
enum Diff:String,  CaseIterable{
    case Hard, Medium, Easy
}

/** Struct for describe parts of an ingredient **/
struct IngredientMO{
    var qty:Float
    var unit:Unit
    var name:String
    
    init(qty:Float, unit:Unit, name:String){
        self.qty = qty
        self.unit = unit
        self.name = name
    }
    
    func ingString() -> String{
        let qty = String(self.qty)
        
        let ingString = "\(qty) \(self.unit.rawValue) \(self.name)"
        print("The String is \(ingString)")
        return ingString
    }
}
//
///** Struct to describe parts of a recipe **/
//struct Recipe {
//     var title:String
//     var mealTypes = [MealType]()
//     var dietaryReqs = [DietaryReq]()
//     var time:Time
//     var difficulty:Diff
//     var serves:Int
//     var ingredients = [Ingredient]()
//     var method = [String]()
//     var image:String
//     var nutrients = [Nutrient]()
//    
//    init(title:String, mealTypes:[MealType], dietaryReqs:[DietaryReq], time:Time, diff:Diff, serves:Int, ingredients:[Ingredient], method:[String], image:String, nutrients:[Nutrient]){
//        self.title = title
//        self.mealTypes = mealTypes
//        self.dietaryReqs = dietaryReqs
//        self.time = time
//        self.difficulty = diff
//        self.serves = serves
//        self.ingredients = ingredients
//        self.method = method
//        self.image = image
//        self.nutrients = nutrients
//        
//    }
//
//}
