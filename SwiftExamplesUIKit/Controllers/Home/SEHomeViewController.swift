//
//  SEHomeViewController.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 12/03/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import UIKit

class SEHomeViewController: UIViewController {

    @IBOutlet weak var exampleListsTableView: UITableView!
    
    var list: [ExampleListModel] =  ExampleListModel.allCases
    let cellReuseIdentifier = CellWithReuseIdentifierModel.homeTableViewCell.rawValue

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfig()
    }
}

// MARK: - Configurations
extension SEHomeViewController {
    func setupConfig() {
        exampleListsTableViewConfig()
    }
    
    func exampleListsTableViewConfig() {
        exampleListsTableView.delegate = self
        exampleListsTableView.dataSource = self
        exampleListsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // device info
        print(DeviceInfo.fullDeviceInfo)
    }
}

extension SEHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
            
        cell.textLabel?.text = list[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch list[indexPath.row] {
        case .normalCollectionView:
            break
        case .otpScreen:
            let otpVC = SEOTPViewController.instantiate(from: .main)
            self.navigationController?.pushViewController(otpVC, animated: true)
        case .attributedString:
            let vc = SEAttributedViewController.instantiate(from: .main)
            self.navigationController?.pushViewController(vc, animated: true)
        case .actionSheet:
            let vc = SEActionSheetViewController.instantiate(from: .main)
            self.navigationController?.pushViewController(vc, animated: true)
        case .datePicker:
            let vc = SEDatePickerViewController.instantiate(from: .main)
            self.navigationController?.pushViewController(vc, animated: true)
        case .picker:
            let vc = SEPickerViewViewController.instantiate(from: .main)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
