//
//  ValidationMessage.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 15/04/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import Foundation

enum ValidationMessage {
    case emptyOTP
    case invalidEmail
    case emptyPassword
    
    var text: String {
        switch self {
        case .emptyOTP:
            return NSLocalizedString("validation_empty_otp", comment: "")
        case .invalidEmail:
            return NSLocalizedString("validation_invalid_email", comment: "")
        case .emptyPassword:
            return NSLocalizedString("validation_empty_password", comment: "")
        }
    }
}
