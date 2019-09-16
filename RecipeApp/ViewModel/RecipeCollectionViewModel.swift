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
    //FIX THIS TO RETURN ALL THHE DATA IN A RECIPE
    func getRecipe(byIndex index: Int) -> (title:String, mealTypes:[String], dietaryReqs:[String], time:String, diff: String, serves:String, ingredients:[String], method:[String], image:UIImage?, nutrients:[(name:String, unit:String)]){
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
    func getNutrientsForRecipe(byIndex index:Int) -> [(name:String, unit:String)]{
        let recipe = manager.recipes[index]
        var nutrients = [(name:String, unit:String)]()
        
        for nut in recipe.nutrients{
            nutrients.append(nut.presentationForm())
        }
        return nutrients
    }
    
}

