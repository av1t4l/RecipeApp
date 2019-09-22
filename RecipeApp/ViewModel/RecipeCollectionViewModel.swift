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
    //reference to the Recipe Manager (Data Source)
    private var manager = RecipeManager()
    
    /** Count: returns the amount of recipes **/
    func count() -> Int{
        let temp = manager.recipes.count
        return temp
    }
    
    /** Returns recipe formatted fro View **/
    func getRecipe(byIndex index: Int) -> (title:String, mealTypes:[String], dietaryReqs:[String], time:String, diff: String, serves:String, ingredients:[String], method:[String], image:UIImage?, nutrients:[Nutrient]){
        print("ini di getrecipe")
        print(index)
        print(manager.recipes.count)
        print(self.getRecipeCount())
        print("selesai")
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
    
    /** Convert [Nutrient] to array of tupe of strings to use in the view controller **/
    func getNutrientsForRecipe(byIndex index:Int) -> [Nutrient]{
        let recipe = manager.recipes[index]
        var nutrients = [Nutrient]()
        
        //iterate over the nutrients and create an array adding sub nutrients too
        for nut in recipe.nutrients{
            nutrients.append(nut)
            //if nutrient has sub nutrients array, iterate over them and add them too
            if nut.hasSubNutrients(){
                let subNutrients = nut.getSubNutrients()
                for subNut in subNutrients{
                    nutrients.append(subNut)
                }
            }
        }
        return nutrients
    }
     /** Format nutrients for the View but with the new values based on users serving input **/
    func getUpdatedNutrientsForRecipe(index: Int, factor:Int) -> [Nutrient]{
        let recipe = manager.recipes[index]
        var nutrients = [Nutrient]()
        
        //iterate over the nutrients and create an array with the sub nutrients too
        for nut in recipe.nutrients{
            //pass in teh servingsixe of recipe and factpr to change by to update the amount value
            nut.updateAmount(factor: factor, recipeServeSize: recipe.serves)
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
    
    func getServingsArray() -> [String]{
        let pickerData = ["1","2","3","4","5","6","7","8","9","10"]
        return pickerData
    }
    
    mutating func addRecipe(recipe: Recipe) {
        manager.addRecipe(recipe: recipe)
    }
    
    func getRecipeCount() -> Int{
        return manager.recipes.count
    }
}

