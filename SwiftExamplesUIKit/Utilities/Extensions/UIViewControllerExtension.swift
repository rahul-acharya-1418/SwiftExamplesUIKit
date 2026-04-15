//
//  UIViewControllerExtension.swift
//  StreamlyTV
//
//  Created by Rahul Acharya on 12/03/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//


import Toast_Swift
import UIKit

extension UIViewController {
    func showAlertWithOk(with message: String) {
        // Create an alert controller
        let alertController = UIAlertController(
            title: DeviceInfo.appName,
            message: message,
            preferredStyle: .alert
        )
        
        // Add an "OK" button to the alert
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )
        
        // Add an "OK" button to the alert
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        )
        
        // Add the "OK" button to the alert
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the alert
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // Function to show success or failure toast
    func showToast(with message: String,
                   isSuccess: Bool,
                   customImage: UIImage? = nil,
                   duration: TimeInterval,
                   position: ToastPosition) {
        
        let bgColor: UIColor = isSuccess ? .systemGreen : .systemRed
        
        var style = ToastStyle()
        
        style.backgroundColor = bgColor
        
        self.view.makeToast(
            message,
            duration: duration,
            position: position,
            image: customImage,
            style: style
        )
    }
    
//    func gotoLoginViewController() {
//        if let viewControllers = navigationController?.viewControllers {
//            for viewController in viewControllers {
//                if viewController is LoginVC {
//                    navigationController?.popToViewController(viewController, animated: true)
//                    break
//                }
//            }
//        }
//    }
}
