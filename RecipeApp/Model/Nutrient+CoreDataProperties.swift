//
//  Nutrient+CoreDataProperties.swift
//  RecipeApp
//
//  Created by Sarah Nurwidhiafitri Sukamto on 07/10/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//
//

import Foundation
import CoreData


extension Nutrient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Nutrient> {
        return NSFetchRequest<Nutrient>(entityName: "Nutrient")
    }

    @NSManaged public var name: String?
    @NSManaged public var amount: Float
    @NSManaged public var staticAmount: Float
    @NSManaged public var unitName: NSObject?
    @NSManaged public var subNutrients: NSObject?
    @NSManaged public var subNutrient: Bool
    @NSManaged public var nickname: String?
    @NSManaged public var recipe: Recipe?

}
