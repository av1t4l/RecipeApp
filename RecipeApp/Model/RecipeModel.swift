//
//  RecipeModel.swift
//  RecipeApp
//
//  Created by Avital Miskella on 30/8/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import Foundation

/** Enum outlining the meal type catagories **/
enum MealType:String{
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case dessert = "Dessert"
    case Ssack = "Snack"
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
    var cookTimeUnit:Character

    init(time:Int, unit:Character){
        self.cookingTime = time
        self.cookTimeUnit = unit
    }
    //add metod here to create the time object
}

/** Enum outlining the difficulty levels **/
enum Diff{
    case Complex, Moderate, Beginner
}

/** Struct for describe parts of an ingredient **/
struct Ingredient{
    var qty:Float
    var unit:Unit
    var name:String
    
    init(qty:Float, unit:Unit, name:String){
        self.qty = qty
        self.unit = unit
        self.name = name
    }
}

/** This may not be needed **/
struct Method{
    var index:Int
    var instruction:String
    
    init(index:Int, instruction:String){
        self.index = index
        self.instruction = instruction
    }
}

/** Struct to describe parts of a recipe **/
struct Recipe {
     var title:String
     var mealTypes = [MealType]()
     var dietaryReqs = [DietaryReq]()
     var time:Time
     var difficulty:Diff
     var serves:Int
     var ingredients = [Ingredient]()
     var method = [String]() //dunno if we need this, maybe just an array of strings
     var image:String
    
    init(title:String, mealTypes:[MealType], dietaryReqs:[DietaryReq], time:Time, diff:Diff, serves:Int, ingredients:[Ingredient], method:[String], image:String){
        self.title = title
        self.mealTypes = mealTypes
        self.dietaryReqs = dietaryReqs
        self.time = time
        self.difficulty = diff
        self.serves = serves
        self.ingredients = ingredients
        self.method = method
        self.image = image
    }

}
