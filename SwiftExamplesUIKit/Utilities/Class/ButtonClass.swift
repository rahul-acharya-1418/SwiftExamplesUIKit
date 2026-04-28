//
//  ButtonClass.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 28/04/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import Foundation
import UIKit

class WhiteOutlineButton: UIButton {
    
    @IBInspectable var isWhite: Bool = true {
         didSet {
             applyStyle()
         }
     }
    
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
        titleLabel?.font = .systemFont(ofSize: 22, weight: .regular)
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = .clear
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 8.0
        clipsToBounds = true
    }
    
    private func applyStyle() {
           if isWhite {
               setTitleColor(.white, for: .normal)
               layer.borderColor = UIColor.white.cgColor
               backgroundColor = .clear
           } else {
               setTitleColor(.systemYellow, for: .normal)
               layer.borderColor = UIColor.systemYellow.cgColor
               backgroundColor = .clear
           }
       }
}


class LoginButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyle()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        applyStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyStyle()
    }

    private func applyStyle() {
        backgroundColor = .darkGray
        clipsToBounds = true
        layer.cornerRadius = 8
        titleLabel?.font = .systemFont(ofSize: 22, weight: .regular)
        setTitleColor(.white, for: .normal)
    }
}
