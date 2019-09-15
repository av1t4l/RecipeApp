//
//  IngredientsCellCollectionViewCell.swift
//  RecipeApp
//
//  Created by Avital Miskella on 15/9/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

class IngredientsCellCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    var ingredients = [String]()
    var tableView = UITableView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with model: [String], table: UITableView) {
        ingredients = model
        tableView = table
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //make this dynamic
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("setting table")
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngTableCell", for: indexPath)
        let title = cell.viewWithTag(2001) as? UILabel
        
        if let title = title{
            title.text = ingredients[indexPath.row]
        }
        return UITableViewCell()
    }
    
}
