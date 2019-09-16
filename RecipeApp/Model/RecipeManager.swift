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
        //test nutrient value
        let carbs = Nutrient(name:"Carbohydrates", amount:30, unitName:Unit.g)
        carbs.addNickname(name: "Carbs")
        carbs.addSubNutrient(name: "Sugar", amount: 100, unitName: Unit.g)
        let Nut = [Nutrient(name:"Energy", amount:30, unitName:Unit.g), carbs , Nutrient(name:"Protien", amount:4, unitName:Unit.g), Nutrient(name:"Fat", amount:3, unitName:Unit.g), Nutrient(name:"Fibre", amount:20, unitName:Unit.g), Nutrient(name:"Sodium", amount:300, unitName:Unit.mg) ]
        
        let Ing = Ingredient(qty:1, unit:Unit.cups, name:"Plain Flour")
        let Ings = [Ing]
        let Step = "Stir till combined."
        let Method = [Step]
        let defRecipe1 = Recipe(title:"Pancakes", mealTypes: [MealType.breakfast], dietaryReqs:[DietaryReq.vegan], time:Time(time:10, unit:"m"), diff: Diff.Easy, serves:5, ingredients: Ings, method:Method, image: "pancakes", nutrients: Nut )
        
        
        let Ing2 = Ingredient(qty:1, unit:Unit.cups, name:"Plain Flour")
        let Ings2 = [Ing2]
        let Step2 = "Mix the flour with 1 cup of the water."
        let Method2 = [Step2]
        let defRecipe2 = Recipe(title:"Peach Muesli", mealTypes: [MealType.breakfast], dietaryReqs:[DietaryReq.vegan], time:Time(time:10, unit:"m"), diff: Diff.Medium, serves:5, ingredients: Ings2, method:Method2, image: "muesli", nutrients: Nut)
        
        
        let Ing3 = Ingredient(qty:1, unit:Unit.cups, name:"Sugar")
        let Ings3 = [Ing3]
        let Step3 = "Beat the butter and sugar."
        let Method3 = [Step3]
        let defRecipe3 = Recipe(title:"Rock Cakes", mealTypes: [MealType.breakfast], dietaryReqs:[DietaryReq.vegan], time:Time(time:10, unit:"m"), diff: Diff.Hard, serves:5, ingredients: Ings3, method:Method3, image: "rock-cakes", nutrients: Nut)
        
        recipes.append(defRecipe1)
        recipes.append(defRecipe2)
        recipes.append(defRecipe3)
        
        print(recipes)
    }
}
