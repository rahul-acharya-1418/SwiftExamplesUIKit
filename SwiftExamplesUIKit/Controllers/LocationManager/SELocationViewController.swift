//
//  SELocationViewController.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 22/06/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import UIKit
var globalZipCode: String = ""

class SELocationViewController: UIViewController {

    @IBOutlet weak var zipcode: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.fetchLocationIfNeeded()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadHomeConfig),
            name: NSNotification.Name("ZipcodeGet"),
            object: nil
        )
    }
    
    @objc func reloadHomeConfig() {
        zipcode.text = globalZipCode
    }

}

/*
 add this info.plist
 <key>NSLocationWhenInUseUsageDescription</key>
 <string>We use your location to determine your ZIP code.</string>
 */
