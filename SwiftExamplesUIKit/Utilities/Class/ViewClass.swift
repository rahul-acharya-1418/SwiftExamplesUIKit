//
//  ViewClass.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 28/04/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import Foundation
import UIKit


class StepRoundCornerView: UIView {
    
    // This method is called when the view is loaded from a nib or storyboard
    override func awakeFromNib() {
        super.awakeFromNib()
        setupConfig()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfig()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConfig()
    }
    
    func setupConfig() {
        clipsToBounds = true
        layer.cornerRadius = bounds.size.width / 2.0
        backgroundColor = .systemBlue
    }
}

