//
//  SuccessMessage.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 15/04/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import Foundation

enum SuccessMessage {
    case otpVerified
    case login
    case profileUpdated
    
    var text: String {
        switch self {
        case .otpVerified:
            return NSLocalizedString("success_otp_verified", comment: "")
        case .login:
            return NSLocalizedString("success_login", comment: "")
        case .profileUpdated:
            return NSLocalizedString("success_profile_updated", comment: "")
        }
    }
}
