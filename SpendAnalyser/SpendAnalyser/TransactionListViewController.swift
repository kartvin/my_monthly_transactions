//
//  TransactionListViewController.swift
//  SpendAnalyser
//
//  Created by Karthik Kumaravel on 1/5/17.
//  Copyright © 2017 Karthik Kumaravel. All rights reserved.
//

import UIKit

class TransactionListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCellIndentifier", for: indexPath)
        cell.textLabel?.text = "Testing"
        cell.detailTextLabel?.text = "Delicious!"
        return cell
    }
    
    func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Test"
        
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
