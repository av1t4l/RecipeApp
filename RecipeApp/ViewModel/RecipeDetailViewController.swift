//
//  ViewController.swift
//  RecipeApp
//
//  Created by Avital Miskella on 24/8/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
    //will have to add serves in later
    var recipe:(title:String, mealTypes:[String], dietaryReqs:[String], time:String, diff: String, serves:String, ingredients:[String], method:[String], image:UIImage?, nutrients:[Nutrient])?
    var recipeIndex:Int = 0
    var nutrients = [Nutrient]()
   
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var diffLabel: UILabel!
    @IBOutlet weak var servesLabel: UILabel!
    @IBOutlet weak var nutSumCollection: UICollectionView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController?.navigationBar.isOpaque = false
        self.navigationController?.navigationBar.alpha = 1.0
        
        if let recipe = recipe{
            // Do any additional setup after loading the view.
            headerImage.image = recipe.image
            recipeNameLabel.text = recipe.title
            timeLabel.text = recipe.time
            diffLabel.text = recipe.diff
            servesLabel.text = recipe.serves
            nutrients = recipe.nutrients
        }
        
        roundCorners()
        
        nutSumCollection.delegate = self
        nutSumCollection.dataSource = self
        
        //FIGURE OUT WHY THIS DOESNT WORK
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //send index table views
        if (segue.identifier == "swipeContainSegue") {
            let childViewController = segue.destination as! SwipeController
            childViewController.recipeIndex = recipeIndex
        }
        //send index to nutrition view controller
        if (segue.identifier == "nutritionDetailSegue") {
            //pass data through the navController by getting the nav controller first then passing through
            let childViewController = segue.destination as! NutritionViewController
            childViewController.recipeIndex = recipeIndex
            
        }
    }
    
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
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nutrients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nutrientSummaryCell", for: indexPath)
        let name = cell.viewWithTag(1000) as? UILabel
        let amount = cell.viewWithTag(1001) as? UILabel
        
        if let name = name, let amount = amount {
            //safely access these variables here
            let currentNut = nutrients[indexPath.row].presentationForm()
           
            if currentNut.nickname != "" {
                 name.text =  currentNut.nickname
            }
            else{
                 name.text =  currentNut.name
            }
            amount.text = currentNut.unit
        }
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 7
        return cell
    }

}

