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
    
   
}
