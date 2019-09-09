//
//  RecipeManager.swift
//  RecipeApp
//
//  Created by Avital Miskella on 30/8/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import Foundation



struct RecipeManager{
    var recipes = [Recipe]()
    
    init(){
        print("making defaults")
        self.makeDefaults()
        
    }
    
    //title:String, mealTypes:[MealType], dietaryReqs:[DietaryReq], time:Time, diff:Diff, serves:Int, ingredients:[Ingredient], method:[Method], image:String
    private mutating func makeDefaults(){
        let Ing = Ingredient(qty:1, unit:Unit.cups, name:"Plain Flour")
        let Ings = [Ing]
        let Step = "Mix the flour with 1 cup of the water."
        let Method = [Step]
        var defRecipe1 = Recipe(title:"Pancakes", mealTypes: [MealType.breakfast], dietaryReqs:[DietaryReq.vegan], time:Time(time:10, unit:"m"), diff: Diff.Beginner, serves:5, ingredients: Ings, method:Method, image: "myPancakes")
        
        
        let Ing2 = Ingredient(qty:1, unit:Unit.cups, name:"Plain Flour")
        let Ings2 = [Ing2]
        let Step2 = "Mix the flour with 1 cup of the water."
        let Method2 = [Step2]
        var defRecipe2 = Recipe(title:"Peach Musli", mealTypes: [MealType.breakfast], dietaryReqs:[DietaryReq.vegan], time:Time(time:10, unit:"m"), diff: Diff.Beginner, serves:5, ingredients: Ings2, method:Method2, image: "myPancakes")
        
        recipes.append(defRecipe1)
        recipes.append(defRecipe2)
        
        print(recipes)
    }
}
