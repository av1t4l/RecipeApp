//
//  SwipeIngViewController.swift
//  RecipeApp
//
//  Created by Avital Miskella on 15/9/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

class IngredientsTableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView! //connection to UI table
   // private let viewModel = RecipeCollectionViewModel() //connection to model
    var ingredients:[String] = [""] //default array of ingredients
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //det delegate and datasource for the Table
        tableView.delegate = self
        tableView.dataSource = self
        
        //set the current recipe and get the ingredients array for it
        //let currentRecipe = viewModel.getRecipe(byIndex: recipeIndex)
        ingredients = [""]
        
    }
    
    override func bindViewModel(viewModel: RecipeCollectionViewModel) {
        let currentRecipe = viewModel.getRecipe(byIndex: recipeIndex)
        ingredients = currentRecipe.ingredients
        
        self.tableView.reloadData()
    }
    
    /** Built In Function:
     number of rows in table, based on amount of ingredients**/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    
    /** Built In Function:
     Format the ingredients cells **/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "swipeCell", for: indexPath) //get cell
        let title = cell.viewWithTag(2001) as? UILabel //get label
        
        //set label based on model data
        if let title = title{
            title.text = ingredients[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
