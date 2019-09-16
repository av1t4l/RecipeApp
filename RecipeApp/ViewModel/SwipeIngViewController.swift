//
//  SwipeIngViewController.swift
//  RecipeApp
//
//  Created by Avital Miskella on 15/9/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

protocol SwipeViewController {
    var recipeIndex: Int { get }
    
}
class SwipeIngViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = RecipeCollectionViewModel()
    var ingredients:[String] = [""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        let currentRecipe = viewModel.getRecipe(byIndex: recipeIndex)
        ingredients = currentRecipe.ingredients
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        print("setting Cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "swipeCell", for: indexPath)
        let title = cell.viewWithTag(2001) as? UILabel
        
        if let title = title{
            title.text = ingredients[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
