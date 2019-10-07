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
    @NSManaged public var mealTypes: NSObject?
    @NSManaged public var dietaryReqs: NSObject?
    @NSManaged public var time: NSObject?
    @NSManaged public var difficulty: NSObject?
    @NSManaged public var serves: Int16
    @NSManaged public var ingredients: NSObject?
    @NSManaged public var method: NSObject?
    @NSManaged public var image: String?
    @NSManaged public var nutrients: Nutrient?

}
