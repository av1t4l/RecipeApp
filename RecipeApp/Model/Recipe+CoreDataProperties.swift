//
//  Recipe+CoreDataProperties.swift
//  RecipeApp
//
//  Created by Sarah Nurwidhiafitri Sukamto on 07/10/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var title: String?
    @NSManaged public var mealTypes: String?
    @NSManaged public var dietaryReqs: String?
    @NSManaged public var cookTime: Int64
    @NSManaged public var cookTimeUnit: String?
    @NSManaged public var difficulty: String?
    @NSManaged public var serves: Int64
    @NSManaged public var ingredients: NSArray?
    @NSManaged public var method: NSObject?
    @NSManaged public var image: String?
    @NSManaged public var nutrients: NSArray?

    /** Converting from NSArray -> IngredientMO to be used by rest of system **/
    var ingredient: [IngredientMO] {
        get{
            var ingArray = [IngredientMO]()
            for i in ingredients!{
                let ing = i as! Ingredient
                if let un = Unit(rawValue: ing.unit!), let name = ing.name {
                    let temp =  IngredientMO(qty: ing.qty, unit: un, name: name )
                    ingArray.append(temp)
                }
                
            }
            return ingArray
        }
        set{
            ingredients = newValue as NSArray
        }
    }

    /** Converting from NSArray -> NutrientMO to be used by rest of system **/
    var nutrient: [NutrientMO] {
        get{
            var nutrArray = [NutrientMO]()
            for n in nutrients!{
                let nutr = n as! Nutrient
                if let un = Unit(rawValue: nutr.unitName!){
                    let temp = NutrientMO(name: nutr.name!, amount: nutr.amount, unitName: un)
                    nutrArray.append(temp)
                }
                
            }
            return nutrArray
        }
        set{
            nutrients = newValue as NSArray
        }
    }
    
    var time: Time {
        get{
            return Time(time: Int(cookTime), unit: cookTimeUnit!)
        }
        set{
            self.cookTime = Int64(newValue.cookingTime)
            self.cookTimeUnit = newValue.cookTimeUnit
        }
    }
    
}
