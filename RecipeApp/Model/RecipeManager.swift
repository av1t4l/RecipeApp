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
    
    private mutating func makeDefaults(){
        //test nutrient value
        let carbs = Nutrient(name:"Carbohydrates", amount:30, unitName:Unit.g)
        carbs.addNickname(name: "Carbs")
        carbs.addSubNutrient(name: "Sugar", amount: 100, unitName: Unit.g)
        let Nut = [Nutrient(name:"Energy", amount:30, unitName:Unit.g), carbs , Nutrient(name:"Protien", amount:4, unitName:Unit.g), Nutrient(name:"Fat", amount:3, unitName:Unit.g), Nutrient(name:"Fibre", amount:20, unitName:Unit.g), Nutrient(name:"Sodium", amount:300, unitName:Unit.mg) ]
        
        let fats = Nutrient(name: "Fat", amount:3.9, unitName: Unit.g)
        fats.addSubNutrient(name: "Saturated", amount: 1.9, unitName: Unit.g)
        let Nut2 = [Nutrient(name:"Energy", amount:30, unitName:Unit.g), carbs , Nutrient(name:"Protien", amount:4, unitName:Unit.g), fats, Nutrient(name:"Fibre", amount:20, unitName:Unit.g), Nutrient(name:"Sodium", amount:300, unitName:Unit.mg) ]
        
        let Ings = [Ingredient(qty:2, unit:Unit.cups, name:"Plain Flour"), Ingredient(qty:70, unit:Unit.ml, name:"Milk"), Ingredient(qty:1, unit:Unit.cups, name:"Butter"), Ingredient(qty:0.5, unit:Unit.cups, name:"Sugar")]
        let Method = ["In a large bowl sift flour","Add milk, sugar and melted butter.", "Stir till combined.","Cook in frying pan until golden brown."]
        let defRecipe1 = Recipe(title:"Pancakes", mealTypes: [MealType.breakfast], dietaryReqs:[DietaryReq.lf], time:Time(time:30, unit:"m"), diff: Diff.Easy, serves:2, ingredients: Ings, method:Method, image: "pancakes", nutrients: Nut )
        
        
        let Ings2 = [Ingredient(qty:1, unit:Unit.cups, name:"Rolled Oats"), Ingredient(qty:250, unit:Unit.g, name:"Fresh Peaches"), Ingredient(qty:0.5, unit:Unit.cups, name:"Coconut Flakes"), Ingredient(qty:1, unit:Unit.cups, name:"Yogurt")]
        let Method2 = ["Peel and chop peaches into bite size pieces.", "Add oats and coconut flakes to bowl and gently combine.", "Top oats with peaches and yogurt."]
        let defRecipe2 = Recipe(title:"Peach Muesli", mealTypes: [MealType.breakfast], dietaryReqs:[DietaryReq.vegan], time:Time(time:10, unit:"m"), diff: Diff.Easy, serves:1, ingredients: Ings2, method:Method2, image: "muesli", nutrients: Nut2)
        
        
        let Ings3 = [Ingredient(qty:2, unit:Unit.cups, name:"Self Raising Flour"), Ingredient(qty:1, unit:Unit.ts, name:"Baking Powder"), Ingredient(qty:70, unit:Unit.g, name:"Butter, softened"), Ingredient(qty:70, unit:Unit.g, name:"Sultanas"), Ingredient(qty:1, unit:Unit.other, name:"Egg")]
        let Method3 = [ "Beat the butter and sugar", "Add flour and rub in until it resembles breadcumbs", "Add sultanas and stir to coat in flour", "Add egg and combine until it's a stiff dough", "Roll into walnut size balls and cook on 180 for 20 minutes." ]
        let defRecipe3 = Recipe(title:"Rock Cakes", mealTypes: [MealType.snack], dietaryReqs:[DietaryReq.vegan], time:Time(time:40, unit:"m"), diff: Diff.Medium, serves:5, ingredients: Ings3, method:Method3, image: "rock-cakes", nutrients: Nut2)
        
        recipes.append(defRecipe1)
        recipes.append(defRecipe2)
        recipes.append(defRecipe3)
        
    }
    
    mutating func addRecipe(recipe: Recipe) {
        recipes.append(recipe)
    }
}
