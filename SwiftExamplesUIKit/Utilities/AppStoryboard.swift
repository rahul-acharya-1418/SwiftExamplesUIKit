//
//  AppStoryboard.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 13/03/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    static var storyboardID: String {
        return String(describing: self)
    }
    
    static func instantiate(from storyboard: AppStoryboard) -> Self {
        return storyboard.instantiateViewController(self)
    }
}

enum AppStoryboard: String {
    
    case main = "Main"
    
    var instance: UIStoryboard {
        UIStoryboard(name: rawValue, bundle: .main)
    }
    
    func instantiateViewController<T: UIViewController>(_ viewController: T.Type) -> T {
        
        let identifier = viewController.storyboardID
        
        guard let vc = instance.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("ViewController with identifier \(identifier) not found in \(rawValue) storyboard.")
        }
        
        return vc
    }
}
