//
//  RecipeCollectionViewModel.swift
//  RecipeApp
//
//  Created by Avital Miskella on 30/8/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import Foundation
import UIKit


struct RecipeCollectionViewModel{
    private let manager = RecipeManager()
    
    func count() -> Int{
        let temp = manager.recipes.count
        return temp
    }

    func getRecipe(byIndex index: Int) -> (title:String, mealTypes:[String], dietaryReqs:[String], time:String, diff: String, serves:String, ingredients:[String], method:[String], image:UIImage?, nutrients:[Nutrient]){
        let recipe = manager.recipes[index]
        let image = UIImage(named: recipe.image)
        var ingredients = [String]()
        for ing in recipe.ingredients{
            ingredients.append(ing.ingString())
        }
        
        var types = [String]()
        for type in recipe.mealTypes{
            types.append(type.rawValue)
        }
        
        var dietReqs = [String]()
        for type in recipe.dietaryReqs{
            dietReqs.append(type.rawValue)
        }
        let time = recipe.time.timeString()
        let serves = "\(recipe.serves)"
        
        let nutrients = self.getNutrientsForRecipe(byIndex: index)
        
        return(title: recipe.title, mealTypes:types, dietaryReqs: dietReqs, time:time , diff: recipe.difficulty.rawValue, serves:serves ,ingredients:ingredients, method: recipe.method, image: image, nutrients:nutrients)
    }
    
    //convert [Nutrient] to array of tupe of strings to use in the view controller
    func getNutrientsForRecipe(byIndex index:Int) -> [Nutrient]{
        let recipe = manager.recipes[index]
        var nutrients = [Nutrient]()
        
        //iterate over the nutrients and create an array with the sub nutrients too
        
        for nut in recipe.nutrients{
            nutrients.append(nut)
            if nut.hasSubNutrients(){
                let subNutrients = nut.getSubNutrients()
                for subNut in subNutrients{
                    nutrients.append(subNut)
                }
            }
        }
        return nutrients
    }
    
}

