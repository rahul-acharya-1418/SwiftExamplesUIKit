//
//  OTPBackgroundView.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 15/04/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import UIKit

class OTPBackgroundView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        clipsToBounds = true
        layer.cornerRadius = 8
    }
}
