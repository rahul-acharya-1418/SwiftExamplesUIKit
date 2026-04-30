//
//  SEActionSheetViewController.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 30/04/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import UIKit

class SEActionSheetViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var paymentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentTextField.delegate = self
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == paymentTextField {
            showAmountMenu()
            return false
        }
        
        return true
    }
    
    func showAmountMenu() {
        
        let alert = UIAlertController(title: "Select Amount", message: nil, preferredStyle: .actionSheet)
        
        let amounts = ["50.0", "100.0"]
        
        for value in amounts {
            alert.addAction(UIAlertAction(title: value, style: .default, handler: { _ in
                self.paymentTextField.text = value
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // iPad fix
        if let popover = alert.popoverPresentationController {
            popover.sourceView = paymentTextField
            popover.sourceRect = paymentTextField.bounds
        }
        
        present(alert, animated: true)
    }
}
