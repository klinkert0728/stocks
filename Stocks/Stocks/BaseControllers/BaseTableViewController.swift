//
//  BaseTableViewController.swift
//  Stocks
//
//  Created by Daniel Klinkert Houfer on 4/21/17.
//  Copyright © 2017 Daniel Klinkert Houfer. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        registerCells()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func configureAppearance() {
        tableView.tableFooterView   = UIView()
        tableView.separatorStyle    = .none
    }
    
    func registerCells() {
        
        tableView.register(UINib(nibName:"EmptyTableViewCell",bundle:nil), forCellReuseIdentifier: "EmptyTableViewCell")
        
    }
}
