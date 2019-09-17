//
//  PopupViewController.swift
//  RecipeApp
//
//  Created by Avital Miskella on 17/9/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

protocol ServesPopDelegate:class {
    func servesContent(controller:ServesPopContentController, didselectItem name:String)
}

class ServesPopContentController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var tableView: UITableView!//connection to the table in view
    private let viewModel = RecipeCollectionViewModel() //connection to model
    var delegate:ServesPopDelegate? //set the serves delegate to get info back from the popOver
    var pickerData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        pickerData = viewModel.getServingsArray()//number of serves data
    }
    
    /** Build In Function:
        set will appear for pop over**/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    /** Build In Function:
        Sets amount of rows in table based on picker data **/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickerData.count
    }
    
    /** Build In Function:
        Formats cells **/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popoverCell", for: indexPath)
        let label = cell.viewWithTag(1000) as? UILabel
        
        if let label = label{
            label.text = pickerData[indexPath.row]
        }
        return cell
    }
    
    /** Build In Function:
        handles on row clicked/selected **/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedServes = pickerData[indexPath.row]
        self.delegate?.servesContent(controller: self, didselectItem: selectedServes)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
