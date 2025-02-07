//
//  RecipeCollectionViewModel.swift
//  RecipeApp
//
//  Created by Avital Miskella on 30/8/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import Foundation
import UIKit



class RecipeCollectionViewModel{
    //reference to the Recipe Manager (Data Source)
    var recipeManager = RecipeManager.shared
    
    /** Count: returns the amount of recipes **/
    func count() -> Int{
        let temp = recipeManager.recipes.count
        return temp
    }
    
    /** Returns recipe formatted for View **/
    func getRecipe(byIndex index: Int) -> (title:String, mealTypes:String, dietaryReqs:String, time:String, diff: String, serves:String, ingredients:[String], method:[String], image:UIImage?, nutrients:[NutrientMO]){
        
        let recipe = recipeManager.recipes[index]
        let image = UIImage(named: recipe.image ?? "imagePlaceholder")
        var ingredients = [String]()

        
        for ing in recipe.ingredient{
            ingredients.append(ing.ingString())
        }
        let time = recipe.time.timeString()
        let serves = "\(recipe.serves)"
        
        let nutrients = self.getNutrientsForRecipe(byIndex: index)
        
        if let type = recipe.mealTypes, let req = recipe.dietaryReqs, let title = recipe.title, let diff = recipe.difficulty {
        
            return(title: title, mealTypes:type, dietaryReqs: req, time:time , diff: diff, serves:serves, ingredients:ingredients, method: recipe.method as! [String], image: image, nutrients:nutrients)
            
        }else{
             return(title: "nil", mealTypes: "nil", dietaryReqs: "nil", time:time , diff: "nil", serves:serves, ingredients:ingredients, method: recipe.method as! [String], image: image, nutrients:nutrients)
        }
    }
    
    /** Convert [Nutrient] to array of tupe of strings to use in the view controller **/
    func getNutrientsForRecipe(byIndex index:Int) -> [NutrientMO]{
        let recipe = recipeManager.recipes[index]
        var nutrients = [NutrientMO]()
        
        //iterate over the nutrients and create an array adding sub nutrients too
        for nut in recipe.nutrient{
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
    func getUpdatedNutrientsForRecipe(index: Int, factor:Int) -> [NutrientMO]{
        let recipe = recipeManager.recipes[index]
        var nutrients = [NutrientMO]()
        
        //iterate over the nutrients and create an array with the sub nutrients too
        for nut in recipe.nutrient{
            //pass in teh servingsixe of recipe and factpr to change by to update the amount value
            nut.updateAmount(factor: factor, recipeServeSize: Int(recipe.serves))
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
}


