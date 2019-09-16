//
//  NutritionViewController.swift
//  RecipeApp
//
//  Created by Avital Miskella on 14/9/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

class NutritionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    
    private let viewModel = RecipeCollectionViewModel()
    var recipeIndex:Int = 0
    var nutrients = [(name:String, unit:String)]()
    
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var servesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let recipe = viewModel.getRecipe(byIndex: recipeIndex)
        
       
        // Do any additional setup after loading the view.
        imageView.image = recipe.image
        titleLabel.text = recipe.title
        timeLabel.text = recipe.time
        difficultyLabel.text = recipe.diff
        servesButton.titleLabel?.text = recipe.serves
        
        //get nutrients string array from view model for this recipe
        nutrients = viewModel.getNutrientsForRecipe(byIndex: recipeIndex)
        tableView.delegate = self
        tableView.dataSource = self
        
        roundCorners()
        
    }
    func roundCorners(){
        //round the edges of the labels
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 7
        titleLabel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        timeLabel.layer.masksToBounds = true
        timeLabel.layer.cornerRadius = 7
        timeLabel.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        
        servesButton.layer.masksToBounds = true
        servesButton.layer.cornerRadius = 7
        servesButton.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nutrients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "nutrientCell", for: indexPath)
        let title = cell.viewWithTag(3000) as? UILabel
        let amount = cell.viewWithTag(3001) as? UILabel
        
        if let title = title, let amount = amount{
            title.text = nutrients[indexPath.row].name
            amount.text = nutrients[indexPath.row].unit
        }
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
