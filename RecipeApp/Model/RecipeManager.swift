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

protocol recipeManagerDelegate: class{
    func didUpdateRecipes()
}

class RecipeManager{
    weak var delegate: recipeManagerDelegate?
    var recipes = [Recipe]()
    
    //creating singleton shared instance
    static let shared = RecipeManager()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext: NSManagedObjectContext
    
    //creatign instance of REST networking class to make REST requests
    var apiCall = REST_Request()
    
    init(){
        print("making defaults")
        managedContext = appDelegate.persistentContainer.viewContext
        apiCall.delegate = self
        loadRecipes()
        
    }
    
    /** Create and save new recipes**/
    public func getNutrientsAndSave(recipe:RecipeMO){
        apiCall.addNutrients(recipe: recipe)
    }
    
    /** Convert RecipeMO to Recipe Core dta object and save to the array**/
    public func addRecipe(title: String, mealType: MealType, dietaryReqs: DietaryReq, time: Time, difficulty: Diff, serves: Int, ingredients: [IngredientMO], method: [String], image: String, nutrients: [NutrientMO]){
        
        let nsRecipe = createRecipe(title: title, mealType: mealType, dietaryReqs: dietaryReqs, time: time, difficulty1: difficulty.rawValue, serves: serves, ingredients: ingredients, method: method, image: image, nutrients: nutrients)
        
        recipes.append(nsRecipe)
        self.save()
        
       
    }
    /** Create recipe to input into core data */
    public func createRecipe(title: String, mealType: MealType, dietaryReqs: DietaryReq, time: Time, difficulty1: String, serves: Int, ingredients: [IngredientMO], method: [String], image: String, nutrients: [NutrientMO]) -> Recipe{
        
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
        nsRecipe.setValue(mealType.rawValue, forKeyPath: "mealTypes")
        nsRecipe.setValue(dietaryReqs.rawValue, forKeyPath: "dietaryReqs")
        nsRecipe.setValue(time.cookingTime, forKeyPath: "cookTime")
        nsRecipe.setValue(time.cookTimeUnit, forKeyPath: "cookTimeUnit")
        nsRecipe.setValue(difficulty1, forKeyPath: "difficulty")
        nsRecipe.setValue(serves, forKeyPath: "serves")
        nsRecipe.setValue(method, forKeyPath: "method")
        nsRecipe.setValue(image, forKeyPath: "image")
        
        return nsRecipe
        
    }
    
    /** Create ingredients to connect to recipe in core data */
    public func createIngredEntity(name:String, qty:Float, unit:String ) -> Ingredient{
        let ingredientEntity = NSEntityDescription.entity(forEntityName: "Ingredient", in: managedContext)!
        let nsIngredient = NSManagedObject(entity: ingredientEntity, insertInto:managedContext) as! Ingredient
        
        nsIngredient.setValue(qty, forKeyPath:"qty")
        nsIngredient.setValue(unit, forKeyPath:"unit")
        nsIngredient.setValue(name, forKeyPath:"name")
        
        return nsIngredient
    }
    
    /** Create nutrient entity for recipe in core data */
    public func createNutrientEntity(nutrient:NutrientMO) -> Nutrient{
        
        let nutrientEntity = NSEntityDescription.entity(forEntityName: "Nutrient", in: managedContext)!
        let nsNutrient = NSManagedObject(entity: nutrientEntity, insertInto:managedContext) as! Nutrient
        
        nsNutrient.setValue(nutrient.getName(), forKeyPath:"name")
        nsNutrient.setValue(nutrient.getNickame(), forKeyPath:"nickname")
        nsNutrient.setValue(nutrient.getAmount(), forKeyPath:"amount")
        nsNutrient.setValue(nutrient.getStaticAmount(), forKeyPath:"staticAmount")
        nsNutrient.setValue(nutrient.getUnitName().rawValue, forKeyPath:"unitName")
        nsNutrient.setValue(nutrient.isSubNutrient(), forKeyPath:"subNutrient") //set is a subnutrient
        
        return nsNutrient
    }
    
    /** Save the Core Data to make persistent */
    public func save(){
        do{
            try managedContext.save()
        }catch  {
            fatalError("Could not save: \(error)")
        }
    }
    
    /** Load recipes from Core Data Store **/
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
    /** To clear core data while testing **/
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

    /** Delegate to make the view refresh on new recipe added **/
    private func updatedRecipes(){
        delegate?.didUpdateRecipes()
    }

}//close recipe manager class
extension RecipeManager: REST_Delegate{
    func didGetNutrients(recipe: RecipeMO) {
        self.addRecipe(title: recipe.title, mealType: recipe.mealTypes, dietaryReqs: recipe.dietaryReqs, time: recipe.time, difficulty: recipe.difficulty, serves: recipe.serves, ingredients: recipe.ingredients, method:recipe.method, image: recipe.image, nutrients: recipe.nutrients)
        loadRecipes()
        updatedRecipes()
     
    }
}
