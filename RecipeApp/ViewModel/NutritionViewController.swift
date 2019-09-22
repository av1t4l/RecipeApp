//
//  NutritionViewController.swift
//  RecipeApp
//
//  Created by Avital Miskella on 14/9/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

class NutritionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    private var viewModel: RecipeCollectionViewModel! //refernece to the model
    var recipeIndex:Int = 0 //indicating the ccurrent recipe
    var nutrients = [Nutrient]() //the nutrients array for that recipe
    
    //declaring the UI Elements
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var servesButton: UIButton!
    
    /** Action for click on ServesButton**/
    @IBAction func adjustServesButtonHandler(_ sender: Any) {
        //get buttons frame
        let button = sender as? UIButton
        let buttonFrame = button?.frame ?? CGRect.zero
        
        //Configure the presentation controller
        let popController = self.storyboard?.instantiateViewController(withIdentifier: "PopOverContentController") as? ServesPopContentController
        popController?.modalPresentationStyle = .popover
        
        popController?.delegate = self //set delegate
       
        //configure the popover and size it
        if let popoverPresentationController = popController?.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.sourceView = button//self.view
            popoverPresentationController.sourceRect = buttonFrame
            popoverPresentationController.delegate = self
            popoverPresentationController.sourceRect = CGRect(x: self.servesButton.bounds.midX, y: self.servesButton.bounds.minY, width: 0, height: 0)
            popController?.preferredContentSize = CGSize(width: 150, height: 200)
            
            //present the popOver on screen
            if let popoverController = popController {
                present(popoverController, animated: true, completion: nil)
            }
        }
    }
    func bindViewModel(viewModel: RecipeCollectionViewModel) {
        self.viewModel = viewModel
    }
    //built in function
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    //built in function
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
    }
    //built in function 
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let recipe = viewModel.getRecipe(byIndex: recipeIndex) //get the current recipe
        
       
        //Set the values in the UI from the values in the model
        imageView.image = recipe.image
        titleLabel.text = recipe.title
        timeLabel.text = recipe.time
        difficultyLabel.text = recipe.diff
        servesButton.setTitle(recipe.serves, for: .normal)
        
        //get nutrients string array from view model for this recipe
        nutrients = viewModel.getNutrientsForRecipe(byIndex: recipeIndex)
        
        //set table delegate and datasource
        tableView.delegate = self
        tableView.dataSource = self
        
        //round corners of all UI Elements
        roundCorners()
        
    }
    
    /** Round the corners for all the UI Elements **/
    func roundCorners(){
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 7
        titleLabel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        timeLabel.layer.masksToBounds = true
        timeLabel.layer.cornerRadius = 7
        timeLabel.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        
        servesButton.layer.masksToBounds = true
        servesButton.layer.cornerRadius = 7
        
    }
    
    /** Inbuilt TableView Method.
        Decided how many rows to create in table **/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nutrients.count
    }
    
    /** Inbuilt TableView Method.
        Format cells in table **/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //decide if cell should be Nutrient or SubNutrient type
        let cell:UITableViewCell
        if nutrients[indexPath.row].isSubNutrient() {
            cell = tableView.dequeueReusableCell(withIdentifier: "subNutrientCell", for: indexPath)
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "nutrientCell", for: indexPath)
        }
        let title = cell.viewWithTag(3000) as? UILabel
        let amount = cell.viewWithTag(3001) as? UILabel
        
        if let title = title, let amount = amount{
            title.text = nutrients[indexPath.row].presentationForm().name
            amount.text = nutrients[indexPath.row].presentationForm().unit
            
        }
        return cell
    }


}

//Allows this class to get data from the popup 
extension NutritionViewController:ServesPopDelegate {
   func servesContent(controller: ServesPopContentController, didselectItem val: String) {
      servesButton.setTitle(val, for: .normal)
        //update the amount here
        nutrients = viewModel.getUpdatedNutrientsForRecipe(index: recipeIndex, factor: Int(val) ?? 0)
        tableView.reloadData()
    
    }
}
