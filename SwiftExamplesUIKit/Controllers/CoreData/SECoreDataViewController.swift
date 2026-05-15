//
//  SECoreDataViewController.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 08/05/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import UIKit

struct User {
    let name: String
    let surname: String
    let email: String
    
    var description: String {
        "User: \(name) \(surname)\nEmail: \(email)"
    }
}

class SECoreDataViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableView.self, forCellReuseIdentifier: "UserCell")
        return table
    }()
    
    private lazy var addbutton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add user", for: .normal)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

/*
 - https://www.youtube.com/watch?v=HkAo995vh_E
 add new file
 selete data model in core data
 select xcdatamodeld
 
 */
