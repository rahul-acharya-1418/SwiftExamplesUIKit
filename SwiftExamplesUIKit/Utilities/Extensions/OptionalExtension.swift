//
//  OptionalExtension.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 15/04/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//


import UIKit

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        return self?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true
    }
}
