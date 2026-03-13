//
//  CollectionViewExtension.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 13/03/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerCells(from cells: [CellWithReuseIdentifierModel]) {
        cells.forEach { cell in
            self.register(
                UINib(nibName: cell.rawValue, bundle: nil),
                forCellWithReuseIdentifier: cell.rawValue
            )
        }
    }
}

enum CellWithReuseIdentifierModel: String {
    case homeTableViewCell = "ExampleListsTableViewCell"
}
