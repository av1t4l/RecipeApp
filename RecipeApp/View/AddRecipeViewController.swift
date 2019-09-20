//
//  AddRecipeViewController.swift
//  RecipeApp
//
//  Created by Sarah Nurwidhiafitri Sukamto on 16/09/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import UIKit

class AddRecipeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mealType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mealType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMealType = mealType[row]
        tvTag.text = selectedMealType
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        tvTag.inputView = pickerView
    }
    
    var selectedMealType: String?
    var selectedDiff: String?
    
    var mealType: [String] = MealType.allCases.map{$0.rawValue}
    var diff = Diff.self
    
    
    @IBOutlet weak var tvTag: UITextField!
    @IBOutlet weak var tvDuration: UITextField!
    @IBOutlet weak var tvDifficulty: UITextField!
    @IBOutlet weak var tvServes: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createPickerView()
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
