//
//  SingleDigitField.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 15/04/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import Foundation
import UIKit

class SingleDigitField: UITextField {
    
    var pressedDelete = false
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        keyboardType = .numberPad
        textAlignment = .center
        textColor = .white
        font = .systemFont(ofSize: 22, weight: .medium)
    }
    
    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        tintColor = .white // hide blinking cursor
        return result
    }
    
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] { [] }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool { false }
    
    override func deleteBackward() {
        pressedDelete = true
        sendActions(for: .editingChanged)
        super.deleteBackward()
    }
}

