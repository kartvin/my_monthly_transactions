//
//  SpendAnalyserViewController.swift
//  SpendAnalyser
//
//  Created by Karthik Kumaravel on 1/6/17.
//  Copyright © 2017 Karthik Kumaravel. All rights reserved.
//

import UIKit
class SpendAnalyserViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
}

extension SpendAnalyserViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpendAnalyserCellIndentifier", for: indexPath)
//        let transactions = self.transactionListDict![sectionsList?[indexPath.section] as Any] as? [TransactionVO]
//        guard transactions != nil else {
//            return cell
//        }
//        
//        let transaction = transactions?[indexPath.row]
//        cell.textLabel?.text = transaction?.merchant as? String
//        let amountStr = "$"
//        cell.detailTextLabel?.text = amountStr.appending((transaction?.amount.stringFormattedWithComma)!)
        cell.textLabel?.text = "Testing"
        let amountStr = "$"
        cell.detailTextLabel?.text = amountStr

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let transactions = self.transactionListDict![sectionsList?[section] as Any] as? [TransactionVO]
        return 10
    }
    
}
