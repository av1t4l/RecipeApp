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
        if pickerView.tag == 0 {
            return mealType.count
        } else if pickerView.tag == 1 {
            return diff.count
        } else {
            return 1
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return mealType[row]
        } else if pickerView.tag == 1 {
            return diff[row]
        } else {
            return "None"
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            selectedMealType = mealType[row]
            tvTag.text = selectedMealType
        } else if pickerView.tag == 1 {
            selectedDiff = diff[row]
            tvDifficulty.text = selectedDiff
        }
        
    }
    
    func createPickerView() {
        let pickerView1 = UIPickerView()
        let pickerView2 = UIPickerView()
        
        pickerView1.delegate = self
        pickerView2.delegate = self
        
        tvTag.inputView = pickerView1
        tvDifficulty.inputView = pickerView2
        
        pickerView1.tag = 0
        pickerView2.tag = 1
    }
    
    var selectedMealType: String?
    var selectedDiff: String?
    
    var mealType: [String] = MealType.allCases.map{$0.rawValue}
    var diff: [String] = Diff.allCases.map{$0.rawValue}
    
    
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
