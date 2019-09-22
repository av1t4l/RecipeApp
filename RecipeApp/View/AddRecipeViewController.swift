//
//  AddRecipeViewController.swift
//  RecipeApp
//
//  Created by Sarah Nurwidhiafitri Sukamto on 16/09/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

class AddRecipeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate, UITextFieldDelegate {
    
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
        if textField == tvTime || textField == tvQuantity {
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
    }
    
    var selectedMealType: String?
    var selectedDiff: String?
    var selectedUnit: String?
    var selectedIngUnit: String?
    
    var mealType: [String] = MealType.allCases.map{$0.rawValue}
    var diff: [String] = Diff.allCases.map{$0.rawValue}
    var ingUnit: [String] = Unit.allCases.map{$0.rawValue}
    var unit:[Character] = ["m", "h"]
    
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
    
    @IBAction func btnAdd(_ sender: UIButton) {
        
        if(tvTitle.hasText && tvTag.hasText && tvTime.hasText && tvUnit.hasText && tvDifficulty.hasText && tvServes.hasText && tvIngredient.hasText && tvQuantity.hasText && tvIngUnit.hasText && tvMethods.hasText){
            
            let title = tvTitle.text!
            let time = Int(tvTime.text!)
            let serves = Int(tvServes.text!)
            let ingredients = tvIngredient.text!
            let methods = tvMethods.text!
            let quantity = Float(tvQuantity.text!)
            
            let createTime = Time(time: time!, unit: unit[selectedUnitRow])
            
            let createIngredient = Ingredient(qty: quantity!, unit: Unit.allCases[selectedIngUnitRow], name: ingredients)
            
            let recipe = Recipe(title: title, mealTypes: [MealType.allCases[selectedMealTypeRow]], dietaryReqs: [], time: createTime, diff: Diff.allCases[selectedDiffRow], serves: serves!, ingredients: [createIngredient], method: [methods], image: "", nutrients: Nut)
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createPickerView()
        tvTime.delegate = self
        tvQuantity.delegate = self
    }
    
    let Nut = [Nutrient(name:"Energy", amount:30, unitName:Unit.g), Nutrient(name:"Protien", amount:4, unitName:Unit.g), Nutrient(name:"Fat", amount:3, unitName:Unit.g), Nutrient(name:"Fibre", amount:20, unitName:Unit.g), Nutrient(name:"Sodium", amount:300, unitName:Unit.mg) ]
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
