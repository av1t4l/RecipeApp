//
//  RecipeManager.swift
//  RecipeApp
//
//  Created by Avital Miskella on 30/8/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct RecipeManager{
    var recipes = [Recipe]()
    //private let apiCall = REST_Request()
    
//    var title:String
//    var mealTypes:[MealType] = []
//    var dietaryReqs:[DietaryReq] = []
//    var time:Time = Time(time: 10, unit: "m")
//    var diff:Diff = Diff.Easy
//    var serves:Int = 0
//    var Ings:[Ingredient] = []
//    var Method:[String] = []
    
    static let shared = RecipeManager()
    //let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//    let managedContext: NSManagedObjectContext
//    //var recipes: [Recipe] = []
    var CD = CoreDataFunctions()
    
    init(){
        print("making defaults")
        //managedContext = appDelegate.persistentContainer.viewContext
        //self.deleteAllData("Recipe")
        CD.deleteAllData("Recipe")
//        makeDefaults()
//        loadRecipes()
        
    }
    
    
    
  
    
    mutating func addRecipe(title: String, mealType: [MealType], dietaryReqs: [DietaryReq], time: Time, difficulty: Diff, serves: Int, ingredients: [IngredientMO], method: [String], image: String, nutrients: [NutrientMO]){
        
        let nsRecipe = CD.createRecipe(title: title, mealType: mealType, dietaryReqs: dietaryReqs, time: time, difficulty1: difficulty.rawValue, serves: serves, ingredients: ingredients, method: method, image: image, nutrients: nutrients)
        
        recipes.append(nsRecipe)
        
       
    }

    
    
    private mutating func makeDefaults(){
        //test nutrient value
        let carbs = NutrientMO(name:"Carbohydrates", amount:30, unitName:Unit.g)
        carbs.addNickname(name: "Carbs")
        carbs.addSubNutrient(name: "Sugar", amount: 100, unitName: Unit.g)
        let Nut = [NutrientMO(name:"Energy", amount:30, unitName:Unit.g), carbs , NutrientMO(name:"Protien", amount:4, unitName:Unit.g), NutrientMO(name:"Fat", amount:3, unitName:Unit.g), NutrientMO(name:"Fibre", amount:20, unitName:Unit.g), NutrientMO(name:"Sodium", amount:300, unitName:Unit.mg) ]

        let fats = NutrientMO(name: "Fat", amount:3.9, unitName: Unit.g)
        fats.addSubNutrient(name: "Saturated", amount: 1.9, unitName: Unit.g)
        let Nut2 = [NutrientMO(name:"Energy", amount:30, unitName:Unit.g), carbs , NutrientMO(name:"Protien", amount:4, unitName:Unit.g), fats, NutrientMO(name:"Fibre", amount:20, unitName:Unit.g), NutrientMO(name:"Sodium", amount:300, unitName:Unit.mg) ]

        let Ings = [IngredientMO(qty:2, unit:Unit.cups, name:"Plain Flour"), IngredientMO(qty:70, unit:Unit.ml, name:"Milk"), IngredientMO(qty:1, unit:Unit.cups, name:"Butter"), IngredientMO(qty:0.5, unit:Unit.cups, name:"Sugar")]
        let Method = ["In a large bowl sift flour","Add milk, sugar and melted butter.", "Stir till combined.","Cook in frying pan until golden brown."]
        self.addRecipe(title:"Pancakes", mealType: [MealType.breakfast], dietaryReqs:[DietaryReq.lf], time:Time(time:30, unit:"m"), difficulty: Diff.Easy, serves:2, ingredients: Ings, method:Method, image: "pancakes", nutrients: Nut )


        let Ings2 = [IngredientMO(qty:1, unit:Unit.cups, name:"Rolled Oats"), IngredientMO(qty:250, unit:Unit.g, name:"Fresh Peaches"), IngredientMO(qty:0.5, unit:Unit.cups, name:"Coconut Flakes"), IngredientMO(qty:1, unit:Unit.cups, name:"Yogurt")]
        let Method2 = ["Peel and chop peaches into bite size pieces.", "Add oats and coconut flakes to bowl and gently combine.", "Top oats with peaches and yogurt."]
        self.addRecipe(title:"Peach Muesli", mealType: [MealType.breakfast], dietaryReqs:[DietaryReq.vegan], time:Time(time:10, unit:"m"), difficulty: Diff.Easy, serves:1, ingredients: Ings2, method:Method2, image: "muesli", nutrients: Nut2)


        let Ings3 = [IngredientMO(qty:2, unit:Unit.cups, name:"Self Raising Flour"), IngredientMO(qty:1, unit:Unit.ts, name:"Baking Powder"), IngredientMO(qty:70, unit:Unit.g, name:"Butter, softened"), IngredientMO(qty:70, unit:Unit.g, name:"Sultanas"), IngredientMO(qty:1, unit:Unit.other, name:"Egg")]
        let Method3 = [ "Beat the butter and sugar", "Add flour and rub in until it resembles breadcumbs", "Add sultanas and stir to coat in flour", "Add egg and combine until it's a stiff dough", "Roll into walnut size balls and cook on 180 for 20 minutes." ]
        self.addRecipe(title:"Rock Cakes", mealType: [MealType.snack], dietaryReqs:[DietaryReq.vegan], time:Time(time:40, unit:"m"), difficulty: Diff.Medium, serves:5, ingredients: Ings3, method:Method3, image: "rock-cakes", nutrients: Nut2)
    }
    

    
//    func addRecipe(recipe: Recipe) {
//        print("in add recipe")
//        //will call API to get nutrient info the the delegator will pass to didGetNutrients and add to the recipe array
//        apiCall.getNutrients(recipe:recipe)
//    }

}//close recipe manager class
//extension RecipeManager: REST_Delegate{
//    func didGetNutrients(nutrients: [NutrientMO], recipe: RecipeMO) {
//        var tempRecipe = recipe
//        tempRecipe.nutrients = nutrients //updating the nutrients to be value API call returned
//        print("adding recipe \(tempRecipe)")
//        recipes.append(tempRecipe)
//    }
//}
