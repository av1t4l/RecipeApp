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

class RecipeManager{
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
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    let managedContext: NSManagedObjectContext
    //var recipes: [Recipe] = []
    var apiCall = REST_Request()
    
    init(){
        print("making defaults")
        managedContext = appDelegate.persistentContainer.viewContext
        self.deleteAllData("Recipe")
        makeDefaults()
        loadRecipes()
        
        let Ings = [IngredientMO(qty:2, unit:Unit.cups, name:"Plain Flour"), IngredientMO(qty:70, unit:Unit.ml, name:"Milk"), IngredientMO(qty:1, unit:Unit.cups, name:"Butter"), IngredientMO(qty:0.5, unit:Unit.cups, name:"Sugar")]
        let Method = ["In a large bowl sift flour","Add milk, sugar and melted butter.", "Stir till combined.","Cook in frying pan until golden brown."]
        
        var test = RecipeMO(title:"Pancakes", mealTypes: [MealType.breakfast], dietaryReqs:[DietaryReq.lf], time:Time(time:30, unit:"m"), diff: Diff.Easy, serves:2, ingredients: Ings, method:Method, image: "pancakes")
        
        apiCall.addNutrients(recipe: test)
        
    }
    
    public func addRecipe(title: String, mealType: [MealType], dietaryReqs: [DietaryReq], time: Time, difficulty: Diff, serves: Int, ingredients: [IngredientMO], method: [String], image: String, nutrients: [NutrientMO]){
        
        let nsRecipe = createRecipe(title: title, mealType: mealType, dietaryReqs: dietaryReqs, time: time, difficulty1: difficulty.rawValue, serves: serves, ingredients: ingredients, method: method, image: image, nutrients: nutrients)
        
        recipes.append(nsRecipe)
        
       
    }

    private func makeDefaults(){
        //test nutrient value
//        let carbs = NutrientMO(name:"Carbohydrates", amount:30, unitName:Unit.g)
//        carbs.addNickname(name: "Carbs")
//        carbs.addSubNutrient(name: "Sugar", amount: 100, unitName: Unit.g)
//        let Nut = [NutrientMO(name:"Energy", amount:30, unitName:Unit.g), carbs , NutrientMO(name:"Protien", amount:4, unitName:Unit.g), NutrientMO(name:"Fat", amount:3, unitName:Unit.g), NutrientMO(name:"Fibre", amount:20, unitName:Unit.g), NutrientMO(name:"Sodium", amount:300, unitName:Unit.mg) ]
//
//        let fats = NutrientMO(name: "Fat", amount:3.9, unitName: Unit.g)
//        fats.addSubNutrient(name: "Saturated", amount: 1.9, unitName: Unit.g)
//        let Nut2 = [NutrientMO(name:"Energy", amount:30, unitName:Unit.g), carbs , NutrientMO(name:"Protien", amount:4, unitName:Unit.g), fats, NutrientMO(name:"Fibre", amount:20, unitName:Unit.g), NutrientMO(name:"Sodium", amount:300, unitName:Unit.mg) ]
//
        
//        let Ings = [IngredientMO(qty:2, unit:Unit.cups, name:"Plain Flour"), IngredientMO(qty:70, unit:Unit.ml, name:"Milk"), IngredientMO(qty:1, unit:Unit.cups, name:"Butter"), IngredientMO(qty:0.5, unit:Unit.cups, name:"Sugar")]
//        let Method = ["In a large bowl sift flour","Add milk, sugar and melted butter.", "Stir till combined.","Cook in frying pan until golden brown."]
//        self.addRecipe(title:"Pancakes", mealType: [MealType.breakfast], dietaryReqs:[DietaryReq.lf], time:Time(time:30, unit:"m"), difficulty: Diff.Easy, serves:2, ingredients: Ings, method:Method, image: "pancakes", nutrients: apiCall.getNutrients(ingredients: Ings, yeild: 2) )
////
//
//        let Ings2 = [IngredientMO(qty:1, unit:Unit.cups, name:"Rolled Oats"), IngredientMO(qty:250, unit:Unit.g, name:"Fresh Peaches"), IngredientMO(qty:0.5, unit:Unit.cups, name:"Coconut Flakes"), IngredientMO(qty:1, unit:Unit.cups, name:"Yogurt")]
//        let Method2 = ["Peel and chop peaches into bite size pieces.", "Add oats and coconut flakes to bowl and gently combine.", "Top oats with peaches and yogurt."]
//        self.addRecipe(title:"Peach Muesli", mealType: [MealType.breakfast], dietaryReqs:[DietaryReq.vegan], time:Time(time:10, unit:"m"), difficulty: Diff.Easy, serves:1, ingredients: Ings2, method:Method2, image: "muesli", nutrients: Nut2)
//
//
//        let Ings3 = [IngredientMO(qty:2, unit:Unit.cups, name:"Self Raising Flour"), IngredientMO(qty:1, unit:Unit.ts, name:"Baking Powder"), IngredientMO(qty:70, unit:Unit.g, name:"Butter, softened"), IngredientMO(qty:70, unit:Unit.g, name:"Sultanas"), IngredientMO(qty:1, unit:Unit.other, name:"Egg")]
//        let Method3 = [ "Beat the butter and sugar", "Add flour and rub in until it resembles breadcumbs", "Add sultanas and stir to coat in flour", "Add egg and combine until it's a stiff dough", "Roll into walnut size balls and cook on 180 for 20 minutes." ]
//        self.addRecipe(title:"Rock Cakes", mealType: [MealType.snack], dietaryReqs:[DietaryReq.vegan], time:Time(time:40, unit:"m"), difficulty: Diff.Medium, serves:5, ingredients: Ings3, method:Method3, image: "rock-cakes", nutrients: Nut2)
    }
    public func createRecipe(title: String, mealType: [MealType], dietaryReqs: [DietaryReq], time: Time, difficulty1: String, serves: Int, ingredients: [IngredientMO], method: [String], image: String, nutrients: [NutrientMO]) -> Recipe{
        
        let recipeEntity = NSEntityDescription.entity(forEntityName: "Recipe", in: managedContext)!
        
        let nsRecipe = NSManagedObject(entity: recipeEntity, insertInto: managedContext) as! Recipe
        
        //iterate over ingredients, create NSobjects
        for i in ingredients {
            let temp = createIngredEntity(name: i.name, qty:i.qty, unit:i.unit.rawValue)
            let addIng = nsRecipe.mutableSetValue(forKey: "ingredients")
            addIng.add(temp)
        }
        
        for n in nutrients{
            let temp = createNutrientEntity(nutrient: n)
            let addNutr = nsRecipe.mutableSetValue(forKey: "nutrients")
            addNutr.add(temp)
        }
        
        nsRecipe.setValue(title, forKeyPath: "title")
        //nsRecipe.setValue(mealType, forKeyPath: "mealTypes")
        //        nsRecipe.setValue(dietaryReqs, forKeyPath: "dietaryReqs")
        nsRecipe.setValue(time.cookingTime, forKeyPath: "cookTime")
        nsRecipe.setValue(time.cookTimeUnit, forKeyPath: "cookTimeUnit")
        nsRecipe.setValue(difficulty1, forKeyPath: "difficulty")
        nsRecipe.setValue(serves, forKeyPath: "serves")
        nsRecipe.setValue(method, forKeyPath: "method")
        nsRecipe.setValue(image, forKeyPath: "image")
        //        nsRecipe.setValue(nutrients, forKeyPath: "nutrients")
        
        return nsRecipe
        
    }
    
    
    public func createIngredEntity(name:String, qty:Float, unit:String ) -> Ingredient{
        let ingredientEntity = NSEntityDescription.entity(forEntityName: "Ingredient", in: managedContext)!
        let nsIngredient = NSManagedObject(entity: ingredientEntity, insertInto:managedContext) as! Ingredient
        
        nsIngredient.setValue(qty, forKeyPath:"qty")
        nsIngredient.setValue(unit, forKeyPath:"unit")
        nsIngredient.setValue(name, forKeyPath:"name")
        
        return nsIngredient
    }
    
    public func createNutrientEntity(nutrient:NutrientMO) -> Nutrient{
        
        let nutrientEntity = NSEntityDescription.entity(forEntityName: "Nutrient", in: managedContext)!
        let nsNutrient = NSManagedObject(entity: nutrientEntity, insertInto:managedContext) as! Nutrient
        
        
        nsNutrient.setValue(nutrient.getName(), forKeyPath:"name")
        nsNutrient.setValue(nutrient.getNickame(), forKeyPath:"nickname")
        nsNutrient.setValue(nutrient.getAmount(), forKeyPath:"amount")
        nsNutrient.setValue(nutrient.getStaticAmount(), forKeyPath:"staticAmount")
        nsNutrient.setValue(nutrient.getUnitName().rawValue, forKeyPath:"unitName")
        nsNutrient.setValue(nutrient.isSubNutrient(), forKeyPath:"subNutrient") //set is a subnutrient
        
        //        var subNutrs = nutrient.getSubNutrients()
        //        for sn in subNutrs{
        //
        //        }
        //nsNutrient.setValue(, forKeyPath:"subNutrients") //set subnutrients array
        
        return nsNutrient
    }
    
    public func save(){
        do{
            try managedContext.save()
        }catch  {
            fatalError("Could not save: \(error)")
        }
    }
    
    public func loadRecipes(){
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
            let result = try managedContext.fetch(fetchRequest)
            //return result as! [Recipe]
            recipes = result as! [Recipe]
        }catch let error as NSError{
            print("Could not load: \(error), \(error.userInfo)")
        }

    }
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                managedContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }//close delete all data

    
//    func addRecipe(recipe: Recipe) {
//        print("in add recipe")
//        //will call API to get nutrient info the the delegator will pass to didGetNutrients and add to the recipe array
//        apiCall.getNutrients(recipe:recipe)
//    }

}//close recipe manager class
extension RecipeManager: REST_Delegate{
    func didGetNutrients(recipe: RecipeMO) {
        //var tempRecipe = recipe
        //tempRecipe.nutrients = nutrients //updating the nutrients to be value API call returned
//        print("adding recipe \(tempRecipe)")
//        recipes.append(tempRecipe)
          self.addRecipe(title: recipe.title, mealType: recipe.mealTypes, dietaryReqs: recipe.dietaryReqs, time: recipe.time, difficulty: recipe.difficulty, serves: recipe.serves, ingredients: recipe.ingredients, method:recipe.method, image: recipe.image, nutrients: recipe.nutrients)
        loadRecipes()
     
    }
}
