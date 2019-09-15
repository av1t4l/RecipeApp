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
    func getRecipe(byIndex index: Int) -> (title:String, mealTypes:[String], dietaryReqs:[String], time:String, diff: String, ingredients:[String], method:[String], image:UIImage?){
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
        
//title:"Rock Cakes", mealTypes: [MealType.breakfast], dietaryReqs:[DietaryReq.vegan], time:Time(time:10, unit:"m"), diff: Diff.Beginner, serves:5, ingredients: Ings3, method:Method3, image: "rock-cakes"
        
        //SOMETHIGN WRONG WITHT HE LAYOUT HERE I THINNK
        return(title: recipe.title, mealTypes:types, dietaryReqs: dietReqs, time:time , diff: recipe.difficulty.rawValue, ingredients:ingredients, method: recipe.method, image: image)
    }
    
}

