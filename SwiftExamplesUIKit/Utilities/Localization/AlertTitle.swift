//
//  AlertTitle.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 15/04/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import Foundation

enum AlertTitle {
    case error
    case success
    case warning
    
    var text: String {
        switch self {
        case .error:
            return NSLocalizedString("alert_title_error", comment: "")
        case .success:
            return NSLocalizedString("alert_title_success", comment: "")
        case .warning:
            return NSLocalizedString("alert_title_warning", comment: "")
        }
    }
}
