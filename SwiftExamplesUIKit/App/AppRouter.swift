//
//  AppRouter.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 29/07/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import UIKit

final class AppRouter {

    private static var window: UIWindow?

    static func configure(window: UIWindow) {
        self.window = window
    }
    
    static func setHomeRoot() {
        guard let window else { return }
        let viewController = AppStoryboard.main.instantiateViewController(SEHomeViewController.self)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }

//    static func setOtpRoot() {
//        guard let window else { return }
//        let viewController = AppStoryboard.main.instantiateViewController(SEOTPViewController.self)
//        let navigationController = UINavigationController(rootViewController: viewController)
//        navigationController.isNavigationBarHidden = true
//        window.rootViewController = navigationController
//        window.makeKeyAndVisible()
//    }
}
