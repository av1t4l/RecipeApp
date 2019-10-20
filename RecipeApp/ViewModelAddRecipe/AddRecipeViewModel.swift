//
//  AddRecipeViewModel.swift
//  RecipeApp
//
//  Created by Sarah Nurwidhiafitri Sukamto on 09/10/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import Foundation
import UIKit

struct AddRecipeViewModel{
    
    private var recipeManager = RecipeManager.shared
    
    mutating func addRecipe(title: String, mealType: MealType, dietaryReqs: DietaryReq, time: Time, difficulty: Diff, serves: Int, ingredients: [IngredientMO], method: [String], image: String){
        
        let temp = RecipeMO(title: title, mealTypes: mealType, dietaryReqs: dietaryReqs, time: time, diff: difficulty, serves: serves, ingredients: ingredients, method: method, image: image)
        recipeManager.getNutrientsAndSave(recipe: temp)
        
//        recipeManager.addRecipe(title: title, mealType: mealType, dietaryReqs: dietaryReqs, time: time, difficulty: difficulty, serves: serves, ingredients: ingredients, method: method, image: image, nutrients: nutrients)
    }
}
