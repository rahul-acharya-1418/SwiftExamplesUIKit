//
//  ScreenInfo.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 15/04/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import Foundation
import UIKit

final class ScreenInfo {
    
    // MARK: - Screen Size
    
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static var size: CGSize {
        return UIScreen.main.bounds.size
    }
    
    // MARK: - Orientation Aware
    
    static var isPortrait: Bool {
        return height >= width
    }
    
    static var isLandscape: Bool {
        return width > height
    }
    
    static var orientedWidth: CGFloat {
        return isPortrait ? width : height
    }
    
    static var orientedHeight: CGFloat {
        return isPortrait ? height : width
    }
    
    // MARK: - Safe Area
    
    static var safeAreaInsets: UIEdgeInsets {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) else {
            return .zero
        }
        return window.safeAreaInsets
    }
    
    static var safeTop: CGFloat {
        return safeAreaInsets.top
    }
    
    static var safeBottom: CGFloat {
        return safeAreaInsets.bottom
    }
    
    static var safeLeft: CGFloat {
        return safeAreaInsets.left
    }
    
    static var safeRight: CGFloat {
        return safeAreaInsets.right
    }
    
    static var hasNotch: Bool {
        return safeBottom > 0
    }
    
    // MARK: - Navigation & Tab Bar
    
    static var statusBarHeight: CGFloat {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return 0
        }
        return scene.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    static var navigationBarHeight: CGFloat {
        return 44 // standard height
    }
    
    static var navigationFullHeight: CGFloat {
        return statusBarHeight + navigationBarHeight
    }
    
    static var tabBarHeight: CGFloat {
        return 49 + safeBottom
    }
}
