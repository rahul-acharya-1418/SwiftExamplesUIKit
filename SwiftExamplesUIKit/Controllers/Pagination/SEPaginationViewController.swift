//
//  SEPaginationViewController.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 21/07/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import UIKit

class SEPaginationViewController: UIViewController {
    
    let viewModel: SEPaginationViewModel = SEPaginationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCharaterList()
    }

}
