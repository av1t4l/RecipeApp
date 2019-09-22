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
    var viewModel: RecipeCollectionViewModel!
    
    func bindViewModel(viewModel: RecipeCollectionViewModel) {
        self.viewModel = viewModel
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabbar = tabBarController as! TabBarViewController
        viewModel = tabbar.viewModel
    }
    
    /** Inbuilt CollectionView Method.
        How many sections in collection **/
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    /** Inbuilt CollectionView Method.
     How many rows in collection **/
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count()
    }
    
    /** Inbuilt CollectionView Method.
        format each cell in the collection **/
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
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 7
        cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return cell
    }
    
     /** Prepares For Segue, send RecipeIndex to RecipeDetailViewcontroller **/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell  = sender as? UICollectionViewCell,
            let indexPath = self.collectionView?.indexPath(for: cell)
            else{return}
        
        if let destination = segue.destination as?
            RecipeDetailViewController{
            
            print(indexPath)
            let recipe = viewModel.getRecipe(byIndex: indexPath.row)
            destination.recipe = recipe
            destination.recipeIndex = indexPath.row
            destination.bindViewModel(viewModel: viewModel)
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tabbar = tabBarController as! TabBarViewController
        viewModel = tabbar.viewModel
        collectionView.reloadData()
        print(viewModel.count())
    }
    
    

}
