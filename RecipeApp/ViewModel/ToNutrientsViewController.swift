//
//  ToNutrientsViewController.swift
//  RecipeApp
//
//  Created by Avital Miskella on 16/9/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

class ToNutrientsViewController: UINavigationController {
    
    var recipeIndex:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //send index to nutrition view controller
        if (segue.identifier == "nutritionDetailSegue2") {
            let childViewController = segue.destination as! NutritionViewController
            childViewController.recipeIndex = recipeIndex
            
        }
    }
    

}
