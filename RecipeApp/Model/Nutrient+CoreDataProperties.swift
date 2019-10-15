//
//  Nutrient+CoreDataProperties.swift
//  RecipeApp
//
//  Created by Avital Miskella on 13/10/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//
//

import Foundation
import CoreData


extension Nutrient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Nutrient> {
        return NSFetchRequest<Nutrient>(entityName: "Nutrient")
    }

    @NSManaged public var amount: Float
    @NSManaged public var name: String?
    @NSManaged public var nickname: String?
    @NSManaged public var staticAmount: Float
    @NSManaged public var subNutrient: Bool
    @NSManaged public var subnutrients: NSObject?
    @NSManaged public var unitName: String?
    @NSManaged public var recipe: Recipe?

}
