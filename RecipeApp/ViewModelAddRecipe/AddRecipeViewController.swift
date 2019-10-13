//
//  AddRecipeViewController.swift
//  RecipeApp
//
//  Created by Sarah Nurwidhiafitri Sukamto on 16/09/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

class AddRecipeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var viewModel = AddRecipeViewModel()
    var ingredientList: [IngredientMO] = []
    var methodList: [String] = []
    
    var pickerView1: UIPickerView!
    var pickerView2: UIPickerView!
    var pickerView3: UIPickerView!
    var pickerView4: UIPickerView!
    
    @IBOutlet var ingredientTable: UITableView!
    @IBOutlet var methodTable: UITableView!
    
    var selectedMealType: String?
    var selectedDiff: String?
    var selectedUnit: String?
    var selectedIngUnit: String?
    
    var mealType: [String] = MealType.allCases.map{$0.rawValue}
    var diff: [String] = Diff.allCases.map{$0.rawValue}
    var ingUnit: [String] = Unit.allCases.map{$0.rawValue}
    var unit:[String] = ["m", "h"]
    
    var selectedMealTypeRow: Int = 0
    var selectedDiffRow: Int = 0
    var selectedUnitRow: Int = 0
    var selectedIngUnitRow: Int = 0
    
    @IBOutlet weak var tvTitle: UITextField!
    @IBOutlet weak var tvTag: UITextField!
    @IBOutlet weak var tvTime: UITextField!
    @IBOutlet weak var tvDifficulty: UITextField!
    @IBOutlet weak var tvServes: UITextField!
    @IBOutlet weak var tvUnit: UITextField!
    @IBOutlet weak var tvIngredient: UITextField!
    @IBOutlet weak var tvMethods: UITextField!
    @IBOutlet weak var tvQuantity: UITextField!
    @IBOutlet weak var tvIngUnit: UITextField!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == ingredientTable {
            return ingredientList.count
        } else {
            return methodList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == ingredientTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
            
            cell.textLabel?.text = ingredientList[indexPath.row].ingString()
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "methodCell", for: indexPath)
            
            cell.textLabel?.text = methodList[indexPath.row]
            
            return cell
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /** Inbuilt PickerView Method
     Sets the number of items in each PickerView **/
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return mealType.count
        } else if pickerView.tag == 1 {
            return diff.count
        } else if pickerView.tag == 2{
            return unit.count
        } else if pickerView.tag == 3{
            return ingUnit.count
        } else {
            return 1
        }
        
    }
    /** Inbuilt PickerView Method
        Populates PickerView items **/
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            selectedMealTypeRow = row
            return mealType[row]
        } else if pickerView.tag == 1 {
            selectedDiffRow = row
            return diff[row]
        } else if pickerView.tag == 2 {
            selectedUnitRow = row
            return String(unit[row])
        } else if pickerView.tag == 3 {
            selectedIngUnitRow = row
            return String(ingUnit[row])
        } else {
            return "None"
        }
        
    }
    
    /** Inbuilt PickerView Method
        Sets TextFields with the chosen item in its PickerView **/
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            selectedMealType = mealType[row]
            tvTag.text = selectedMealType
        } else if pickerView.tag == 1 {
            selectedDiff = diff[row]
            tvDifficulty.text = selectedDiff
        } else if pickerView.tag == 2 {
            selectedUnit = String(unit[row])
            tvUnit.text = selectedUnit
        } else if pickerView.tag == 3 {
            selectedIngUnit = ingUnit[row]
            tvIngUnit.text = selectedIngUnit
        }
        
    }
    
    /** Inbuilt TextField Method
        Restrict input to numbers **/
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tvTime || textField == tvQuantity || textField == tvServes{
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    /*
     Create the pickerViews
     */
    func createPickerView() {
        let pickerView1 = UIPickerView()
        let pickerView2 = UIPickerView()
        let pickerView3 = UIPickerView()
        let pickerView4 = UIPickerView()
        
        pickerView1.delegate = self
        pickerView2.delegate = self
        pickerView3.delegate = self
        pickerView4.delegate = self
        
        tvTag.inputView = pickerView1
        tvDifficulty.inputView = pickerView2
        tvUnit.inputView = pickerView3
        tvIngUnit.inputView = pickerView4
        
        pickerView1.tag = 0
        pickerView2.tag = 1
        pickerView3.tag = 2
        pickerView4.tag = 3
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        tvTag.inputAccessoryView = toolBar
        tvDifficulty.inputAccessoryView = toolBar
        tvUnit.inputAccessoryView = toolBar
        tvIngUnit.inputAccessoryView = toolBar
    }
    
    @objc func donePicker() {
        view.endEditing(true)
    }
  
    @IBAction func addIngButton(_ sender: Any) {
        
        if let name = tvIngredient.text, let quantity = Float(tvQuantity.text!) {
            
            let ingredient = IngredientMO(qty: quantity, unit: Unit.allCases[selectedIngUnitRow], name: name)
            
            ingredientList.append(ingredient)
            ingredientTable.reloadData()
        }
    }
    
    
    @IBAction func addMethodButton(_ sender: Any) {
        if let method = tvMethods.text {
            methodList.append(method)
            methodTable.reloadData()
        }
    }
    
    @IBAction func btnAdd(_ sender: UIButton) {
        
        if let tvTitle = tvTitle.text, let _ = tvTag.text, let tvTime = Int(tvTime.text!), let _ = tvUnit.text, let _ = tvDifficulty.text, let tvServes = Int(tvServes.text!), let _ = tvIngUnit.text {
            
            let createTime = Time(time: tvTime, unit: unit[selectedUnitRow])

            viewModel.addRecipe(title: tvTitle, mealType: [MealType.allCases[selectedMealTypeRow]], dietaryReqs: [], time: createTime, difficulty: Diff.allCases[selectedDiffRow], serves: tvServes, ingredients: ingredientList, method: methodList, image: "imagePlaceholder", nutrients: Nut)
            
            let alertController = UIAlertController(title: "Add Recipe", message: "Successfully added \(tvTitle)", preferredStyle: .alert)
            let doneButton = UIAlertAction(title: "Done", style: .default, handler: {(action) -> Void in print("Done")})
            
            alertController.addAction(doneButton)
            
            self.navigationController!.present(alertController, animated: true, completion: nil)
            print("Got here")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "New Recipe"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        ingredientTable.dataSource = self
        methodTable.dataSource = self
        
        createPickerView()
        tvTime.delegate = self
        tvQuantity.delegate = self
        tvServes.delegate = self
        
//        let tabbar = tabBarController as! TabBarViewController
//        viewModel = tabbar.viewModel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearAllTexts()
    }
    
    let Nut = [NutrientMO(name:"Energy", amount:30, unitName:Unit.g), NutrientMO(name:"Protien", amount:4, unitName:Unit.g), NutrientMO(name:"Fat", amount:3, unitName:Unit.g), NutrientMO(name:"Fibre", amount:20, unitName:Unit.g), NutrientMO(name:"Sodium", amount:300, unitName:Unit.mg) ]
    
    public func clearAllTexts(){
        for view in self.view.subviews{
            if view is UITextField{
                let field: UITextField = view as! UITextField
                field.text = ""
            }
        }
    }
    

     //MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         //Get the new view controller using segue.destination.
         //Pass the selected object to the new view controller.
    }

}
