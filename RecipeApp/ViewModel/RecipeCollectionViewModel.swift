//
//  RecipeCollectionViewModel.swift
//  RecipeApp
//
//  Created by Avital Miskella on 30/8/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import Foundation
import UIKit


struct RecipeCollectionViewModel{
    private let manager = RecipeManager()
    
    func count() -> Int{
        let temp = manager.recipes.count
        return temp
    }
    
    func getRecipe(byIndex index: Int) -> (title:String, image:UIImage?){
        let recipe = manager.recipes[index]
        let image = UIImage(named: recipe.image)
        print(recipe.title)
        return(title: recipe.title, image: image)
    }
    
}

