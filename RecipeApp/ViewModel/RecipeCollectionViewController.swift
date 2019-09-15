//
//  RecipeCollectionViewController.swift
//  RecipeApp
//
//  Created by Avital Miskella on 30/8/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RecipeCell"


class RecipeCollectionViewController: UICollectionViewController {
    private let viewModel = RecipeCollectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let imageView = cell.viewWithTag(1000) as? UIImageView
        let title = cell.viewWithTag(1001) as? UILabel
        print("in load collect")
    
        if let imageView = imageView, let title = title {
            //safely access these variables here
            let currentRecipe = viewModel.getRecipe(byIndex: indexPath.item)
            imageView.image = currentRecipe.image
            title.text = currentRecipe.title
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell  = sender as? UICollectionViewCell,
            let indexPath = self.collectionView?.indexPath(for: cell)
            else{return}
        if let destination = segue.destination as?
            RecipeDetailViewController{
            let recipe = viewModel.getRecipe(byIndex: indexPath.row)
            destination.recipe = recipe
            destination.recipeIndex = indexPath.row
        }

    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
