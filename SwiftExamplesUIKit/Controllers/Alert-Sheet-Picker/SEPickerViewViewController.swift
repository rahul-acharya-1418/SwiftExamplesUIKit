//
//  SEPickerViewViewController.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 30/04/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import UIKit

class SEPickerViewViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet weak var paymentMethodTextField: UITextField!
    
    let categories = [
        "Gas Bill",
        "Energy Bill",
        "Flat/Society Maintenance",
        "Food",
        "Grocery Bill",
        "Fuel Consumption Bill"
    ]
    
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewConfig()
    }
    
    func pickerViewConfig() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Assign picker to both fields
        paymentMethodTextField.inputView = pickerView
        
        paymentMethodTextField.tintColor = .clear
        
        // Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(doneTapped)
        )
        
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        
        paymentMethodTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneTapped() {
        paymentMethodTextField?.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        paymentMethodTextField.text = categories[row]
    }
    
}
