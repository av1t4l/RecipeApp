//
//  SwipeMethodViewController.swift
//  RecipeApp
//
//  Created by Avital Miskella on 15/9/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

class SwipeMethodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = RecipeCollectionViewModel()
    var recipeIndex: Int = 0
    var method:[String] = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let currentRecipe = viewModel.getRecipe(byIndex: recipeIndex)
        method = currentRecipe.method
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return method.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        print("setting Cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "swipeCell", for: indexPath)
        let title = cell.viewWithTag(2001) as? UILabel
        
        if let title = title{
            title.text = method[indexPath.row]
        }
        return cell
    }
}
