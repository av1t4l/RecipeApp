//
//  BaseViewController.swift
//  RecipeApp
//
//  Created by Avital Miskella on 16/9/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit


/** Super Class:
    To allow the page view controller to have an array of a generic type, but still pass data to the new view controllers **/
class BaseViewController: UIViewController {
    
    var recipeIndex: Int! //refers to the current recipe
    var viewModel: RecipeCollectionViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func bindViewModel(viewModel: RecipeCollectionViewModel) {
        self.viewModel = viewModel
    }
  
}
