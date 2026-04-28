//
//  SEAttributedViewController.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 28/04/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import UIKit

class SEAttributedViewController: UIViewController {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var fifthLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set single highlights text
        firstLabel.setHighlightedText(
            "dummy text",
            font: .systemFont(ofSize: 18, weight: .medium),
            textColor: .label,
            highlightColor: .systemYellow
        )
        
        // set multiple highlights text
        secondLabel.makeHighlightedText(
            highlights: ["Lorem Ipsum", "typesetting"],
            baseColor: .label,
            highlightColor: .systemYellow,
            font: .systemFont(ofSize: 18, weight: .medium)
        )
        
        thirdLabel.font(.regular, 14)
        fourthLabel.font(.mediumItalic, 14)
        fifthLabel.font(.bold, 14)
    }
}
/*
 ### 1. Add font files to project

 * Drag & drop your `.ttf` or `.otf` files into Xcode
 * Make sure **“Copy items if needed”** is checked
 * Ensure your app target is selected

 ---

 ### 2. Update `Info.plist`

 Add this key:

 ```
 Fonts provided by application (UIAppFonts)
 ```

 Then add your font file names exactly:

 ```
 <array>
     <string>MyFont-Regular.ttf</string>
     <string>MyFont-Bold.ttf</string>
 </array>
 ```

 ### 2. Usages
 thirdLabel.font(.regular, 14)
 */
