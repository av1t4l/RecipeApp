//
//  SwipeMethodViewController.swift
//  RecipeApp
//
//  Created by Avital Miskella on 15/9/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

class MethodTableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
   
   
    @IBOutlet weak var tableView: UITableView! //connection to view
    //private var viewModel: RecipeCollectionViewModel! //connection to model
    var method:[String] = [""] //default method array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegate and datasource for table on view
        tableView.delegate = self
        tableView.dataSource = self
        
        //get the current recipe and its method array
        //let currentRecipe = viewModel.getRecipe(byIndex: recipeIndex)
        method = [""]
        
    }
    
    override func bindViewModel(viewModel: RecipeCollectionViewModel) {
        let currentRecipe = viewModel.getRecipe(byIndex: recipeIndex)
        method = currentRecipe.method
        
        self.tableView.reloadData()
    }
    
    
    /** Built In Function:
     number of rows in table, based on amount of steps **/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return method.count
    }
    
    /** Built In Function:
     Format the method cells **/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        print("setting Cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "swipeCell", for: indexPath)
        let title = cell.viewWithTag(2001) as? UILabel
        
        if let title = title{
            title.text = method[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
