//
//  NutritionViewController.swift
//  RecipeApp
//
//  Created by Avital Miskella on 14/9/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

class NutritionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
   
   
    
    
    private let viewModel = RecipeCollectionViewModel()
    var recipeIndex:Int = 0
    var nutrients = [Nutrient]()
    
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var servesButton: UIButton!
    
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    let pickerData = ["1","2","3","4","5","6","7","8","9","10"]
    
    @IBAction func ServesButtonClick(_ sender: Any) {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)

        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
        
    }
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let recipe = viewModel.getRecipe(byIndex: recipeIndex)
        
       
        // Do any additional setup after loading the view.
        imageView.image = recipe.image
        titleLabel.text = recipe.title
        timeLabel.text = recipe.time
        difficultyLabel.text = recipe.diff
        servesButton.setTitle(recipe.serves, for: .normal)
        
        //get nutrients string array from view model for this recipe
        nutrients = viewModel.getNutrientsForRecipe(byIndex: recipeIndex)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        roundCorners()
        
    }
    func roundCorners(){
        //round the edges of the labels
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 7
        titleLabel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        timeLabel.layer.masksToBounds = true
        timeLabel.layer.cornerRadius = 7
        timeLabel.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        
        servesButton.layer.masksToBounds = true
        servesButton.layer.cornerRadius = 7
        servesButton.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nutrients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //get the value that was selected
        servesButton.setTitle(pickerData[row], for: .normal)
        print(pickerData[row])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
