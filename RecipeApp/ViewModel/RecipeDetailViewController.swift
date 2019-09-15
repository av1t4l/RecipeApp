//
//  ViewController.swift
//  RecipeApp
//
//  Created by Avital Miskella on 24/8/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
   

    //will have to add serves in later
    var recipe:(title:String, mealTypes:[String], dietaryReqs:[String], time:String, diff: String, serves:String, ingredients:[String], method:[String], image:UIImage?)?
    var recipeIndex:Int = 0
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var diffLabel: UILabel!
    @IBOutlet weak var servesLabel: UILabel!
    @IBOutlet weak var nutSumCollection: UICollectionView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        if let recipe = recipe{
            // Do any additional setup after loading the view.
            headerImage.image = recipe.image
            recipeNameLabel.text = recipe.title
            timeLabel.text = recipe.time
            diffLabel.text = recipe.diff
            servesLabel.text = recipe.serves
        
        }
        
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
       
        //FIGURE OUT WHY THIS DOESNT WORK
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "swipeContainSegue") {
            let childViewController = segue.destination as! SwipeController
            childViewController.recipeIndex = recipeIndex
    
        }
    }
    

}

