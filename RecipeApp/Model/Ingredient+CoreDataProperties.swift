//
//  Ingredient+CoreDataProperties.swift
//  RecipeApp
//
//  Created by Avital Miskella on 12/10/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var name: String?
    @NSManaged public var qty: Float
    @NSManaged public var unit: String?
    @NSManaged public var recipe: Recipe?

}
