//
//  TableViewController.swift
//  TableViewTrial
//
//  Created by Sarah Nurwidhiafitri Sukamto on 25/09/19.
//  Copyright © 2019 Sarah Nurwidhiafitri Sukamto. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "New Recipe"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return tableView.numberOfRows(inSection: section)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        
        return cell
    }
    
    
    
    
}
