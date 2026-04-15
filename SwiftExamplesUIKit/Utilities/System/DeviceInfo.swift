//
//  DeviceInfo.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 15/04/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import Foundation
import UIKit

final class DeviceInfo {
    
    // MARK: - App Info
    
    /// SwiftExamples
    static var appName: String {
        if let name = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String {
            return name
        } else if let name = Bundle.main.infoDictionary?["CFBundleName"] as? String {
            return name
        }
        return "Unknown App"
    }
    
    /// 1.0
    static var version: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0"
    }
    
    /// 1
    static var buildNumber: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "0"
    }
    
    
    // MARK: - Device Model
    
    static var deviceModel: String {
        let identifier = deviceIdentifier()
        return deviceMap[identifier] ?? identifier
    }
    
    private static func deviceIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let mirror = Mirror(reflecting: systemInfo.machine)
        let identifier = mirror.children.reduce("") { acc, element in
            guard let value = element.value as? Int8, value != 0 else { return acc }
            return acc + String(UnicodeScalar(UInt8(value)))
        }
        
        return identifier
    }
    
    // MARK: - Model Map (add more as needed)
    
    private static let deviceMap: [String: String] = [
        // iPhone
        "iPhone15,2": "iPhone 14 Pro",
        "iPhone15,3": "iPhone 14 Pro Max",
        "iPhone16,1": "iPhone 15",
        "iPhone16,2": "iPhone 15 Plus",
        "iPhone16,3": "iPhone 15 Pro",
        "iPhone16,4": "iPhone 15 Pro Max",
        
        // iPad
        "iPad13,1": "iPad Air (4th gen)",
        "iPad13,2": "iPad Air (4th gen)",
        "iPad13,16": "iPad Air (5th gen)",
        "iPad13,17": "iPad Air (5th gen)",
        
        // Simulator
        "x86_64": "Simulator",
        "arm64": "Simulator"
    ]
    
    // MARK: - Device Info
    
    static var isiPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isiPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    static var deviceType: String {
        return isiPad ? "iPad" : "iPhone"
    }
    
    static var deviceName: String {
        return UIDevice.current.name
    }
    
    static var systemName: String {
        return UIDevice.current.systemName // iOS
    }
    
    // MARK: - OS Version
     static var osVersion: OperatingSystemVersion {
         return ProcessInfo.processInfo.operatingSystemVersion
     }
     
     static var osMajorVersion: Int {
         return osVersion.majorVersion
     }
     
     static var osMinorVersion: Int {
         return osVersion.minorVersion
     }
     
     static var osPatchVersion: Int {
         return osVersion.patchVersion
     }
     
     static var osFullVersion: String {
         return "\(osMajorVersion).\(osMinorVersion).\(osPatchVersion)"
     }
    
    // MARK: - Combined Info (🔥 useful for logs)
     
     static var fullDeviceInfo: String {
         return """
         App: \(appName)
         Build Version: \(version)(\(buildNumber))
         OS: \(systemName) \(osFullVersion)
         Device Model: \(deviceModel)
         """
     }
}

