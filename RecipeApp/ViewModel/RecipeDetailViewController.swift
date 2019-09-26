//
//  ViewController.swift
//  RecipeApp
//
//  Created by Avital Miskella on 24/8/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //Recipe object the view needs from the previous view
    var recipe:(title:String, mealTypes:[String], dietaryReqs:[String], time:String, diff: String, serves:String, ingredients:[String], method:[String], image:UIImage?, nutrients:[Nutrient])?
    var recipeIndex:Int = 0 //the current recipe being displayed
    var nutrients = [Nutrient]() //the nutrients array from that recipe
    
    var viewModel: RecipeCollectionViewModel!
    
    //Linking all the UIElements on the screen
    @IBOutlet weak var collectionLabel: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var diffLabel: UILabel!
    @IBOutlet weak var servesLabel: UILabel!
    @IBOutlet weak var nutSumCollection: UICollectionView!
    
    //Runs on load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make the nav bar transparent
        self.navigationController?.navigationBar.isOpaque = false
        self.navigationController?.navigationBar.alpha = 1.0
        
        //set the values of the UI Elements on screen
        if let recipe = recipe{
            // Do any additional setup after loading the view.
            headerImage.image = recipe.image
            recipeNameLabel.text = recipe.title
            timeLabel.text = recipe.time
            diffLabel.text = recipe.diff
            servesLabel.text = recipe.serves
            nutrients = recipe.nutrients
        }
        
        //round the corners of all the elements
        roundCorners()
        
        //set the delegate for the collection view on the screen
        nutSumCollection.delegate = self
        nutSumCollection.dataSource = self
        
        //make sure the cell isnt touching the sides
        nutSumCollection.contentInset =  UIEdgeInsets(top: 30, left: 5, bottom: 30, right: 5)
        
    }
    func bindViewModel(viewModel: RecipeCollectionViewModel) {
        self.viewModel = viewModel
    }
    
    /** Prepares For Segue, passes the data to NutritionViewController and Swipe Controller **/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //send index table views
        if (segue.identifier == "swipeContainSegue") {
            let childViewController = segue.destination as! SwipeController
            childViewController.recipeIndex = recipeIndex
            childViewController.bindViewModel(viewModel: viewModel)
        }
        //send index to nutrition view controller
        if (segue.identifier == "nutritionDetailSegue") {
            //pass data through the navController by getting the nav controller first then passing through
            let childViewController = segue.destination as! NutritionViewController
            childViewController.recipeIndex = recipeIndex
            childViewController.bindViewModel(viewModel: viewModel)
            
        }
    }
    
    /** Round the corners for all the UI Elements **/
    func roundCorners(){
        //round the edges of the labels
        recipeNameLabel.layer.masksToBounds = true
        recipeNameLabel.layer.cornerRadius = 7
        recipeNameLabel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        timeLabel.layer.masksToBounds = true
        timeLabel.layer.cornerRadius = 7
        timeLabel.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        
        servesLabel.layer.masksToBounds = true
        servesLabel.layer.cornerRadius = 7
        servesLabel.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
        
        nutSumCollection.layer.masksToBounds = true
        nutSumCollection.layer.cornerRadius = 7
        
        collectionLabel.layer.masksToBounds = true
        collectionLabel.layer.cornerRadius = 7
        collectionLabel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
    }
    
    /** Inbuilt CollectionView Method.
     Decided how many cells to create in collection **/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nutrients.count
    }
    
    /** Inbuilt CollectionView Method.
     Format cells in collection **/
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nutrientSummaryCell", for: indexPath)
        let name = cell.viewWithTag(1000) as? UILabel
        let amount = cell.viewWithTag(1001) as? UILabel
        
        if let name = name, let amount = amount {
            let currentNut = nutrients[indexPath.row].presentationForm()
            //if has nickname, set nickname
            if currentNut.nickname != "" {
                name.text =  currentNut.nickname
            }
            else{
                name.text =  currentNut.name
            }
            amount.text = currentNut.unit
        }
        //round the corners of each cell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 7
        return cell
    }
    
}

