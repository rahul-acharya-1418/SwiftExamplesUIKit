//
//  LabelExtension.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 12/03/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    /// Applies attributed text to the label and highlights a specific substring with a different color.
    ///
    /// This helper is reusable across the Auth module to highlight required field indicators
    /// such as `*` in labels like "Email *" or "Password *".
    ///
    /// Example usage:
    /// `lblEmail.text = "Email *"`
    /// `lblEmail.setAttributedText(highlightText: "*")`
    ///
    /// - Parameters:
    ///   - highlightText: The substring within the label's text that should be highlighted (e.g. "*").
    ///   - attributedFont: The font applied to the entire text. Default is medium system font of size 18.
    ///   - primaryTextColor: The default color applied to the full label text.
    ///   - highlightTextTextColor: The color applied only to the highlighted substring.
    func setHighlightedText(
        _ highlightedText: String,
        font: UIFont = UIFont.systemFont(ofSize: 18, weight: .medium),
        textColor: UIColor = .white,
        highlightColor: UIColor = .red
    ) {
        guard let fullText = text, fullText.contains(highlightedText) else { return }
        
        let attributed = NSMutableAttributedString(
            string: fullText,
            attributes: [
                .foregroundColor: textColor,
                .font: font
            ]
        )
        
        if let range = fullText.range(of: highlightedText) {
            let nsRange = NSRange(range, in: fullText)
            attributed.addAttribute(
                .foregroundColor,
                value: highlightColor,
                range: nsRange
            )
        }
        
        self.attributedText = attributed
    }
}
