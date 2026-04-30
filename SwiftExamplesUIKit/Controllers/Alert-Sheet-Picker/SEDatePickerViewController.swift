//
//  SEDatePickerViewController.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 30/04/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import UIKit

class SEDatePickerViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
    }
    
    // MARK: - Date Picker Setup
    private func setupDatePicker() {
        
        dateTextField.tintColor = .clear
        datePicker.datePickerMode = .date
        
        datePicker.preferredDatePickerStyle = .inline
        
        dateTextField.inputView = datePicker

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
            action: #selector(donePressed)
        )

        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        dateTextField.inputAccessoryView = toolbar
    }

    @objc private func donePressed() {

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
//        formatter.dateStyle = .short
//        formatter.dateStyle = .full
//        formatter.dateStyle = .long
//        formatter.dateStyle = .none

        dateTextField.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }

}
