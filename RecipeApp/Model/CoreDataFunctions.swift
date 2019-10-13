//
//  CoreDataFunctions.swift
//  RecipeApp
//
//  Created by Avital Miskella on 13/10/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataFunctions {
    let shared = RecipeManager.shared
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext: NSManagedObjectContext
    
    init(){
        managedContext = appDelegate.persistentContainer.viewContext
        
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
    
    public func loadRecipes() -> [Recipe]{
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
            let result = try managedContext.fetch(fetchRequest)
            return result as! [Recipe]
            //recipes = result as! [Recipe]
        }catch let error as NSError{
            print("Could not load: \(error), \(error.userInfo)")
        }
        return []
        
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
}
