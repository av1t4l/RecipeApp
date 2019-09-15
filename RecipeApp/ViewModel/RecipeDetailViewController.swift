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
    var recipe:(title:String, mealTypes:[String], dietaryReqs:[String], time:String, diff: String, ingredients:[String], method:[String], image:UIImage?)?

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
            servesLabel.text = "Easy"
        
        }
       
        //FIGURE OUT WHY THIS DOESNT WORK
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("running number or rows")
//        if let num = recipe?.ingredients.count{
//            return num
//        }
//        return 0
//        
//    }
//    
//    
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 2
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        print("creating collection")
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "swipeCell", for: indexPath) as! IngredientsCellCollectionViewCell
//        if let recipe = recipe{
//            cell.configure(with: recipe.ingredients, table: tableView)
//        }
//        return cell
//    }
    

}

