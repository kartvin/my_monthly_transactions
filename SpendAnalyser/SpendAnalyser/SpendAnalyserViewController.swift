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
    @IBOutlet weak var expesneLabel: UILabel!
    fileprivate var sectionsList: Array<String>?
    fileprivate var transactionListDict: NSMutableDictionary?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.sortAndLoadAnalyserResults()
    }

    private func sortAndLoadAnalyserResults() {
        guard let transactions = ServiceManager.sharedInstance.transactionList else {
            return
        }
        var transactionDates: [String]? = []
        self.transactionListDict = NSMutableDictionary()
        
        for transactionItem in transactions {
            transactionDates?.append(transactionItem.transactionDisplayMonth as String)
        }
        self.sectionsList = Array(Set(transactionDates! as [String]))
        self.sectionsList = self.sectionsList?.sorted { $0 > $1 }
        
        var totalIncome = 0
        var totalEpx = 0
        
        for transactionDate in self.sectionsList! {
            let filteredArray = transactions.filter() { $0.transactionDisplayMonth == transactionDate }
            let crediCardPaymentList = filteredArray.filter() {$0.amount > 0}
            let crediCardSpentList = filteredArray.filter() {$0.amount < 0}
            let totalIncomeForMonth = crediCardPaymentList.reduce(0) { $0 + $1.amount}
            let totalExpForMonth = crediCardSpentList.reduce(0) { $0 + $1.amount}
            
            totalIncome += abs(totalIncomeForMonth)
            totalEpx += abs(totalExpForMonth)
            let expString = "$"+abs(totalIncomeForMonth).stringFormattedWithComma+" income vs $"+abs(totalExpForMonth).stringFormattedWithComma+" expense"
            self.transactionListDict?.setValue(expString, forKey: transactionDate)
        }
        self.expesneLabel.text = "Average income of $" + (totalIncome/(sectionsList?.count)!).stringFormattedWithComma + " vs average expense of $" + (totalEpx/(sectionsList?.count)!).stringFormattedWithComma
        
        self.tableView.reloadData()
    }
}

extension SpendAnalyserViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpendAnalyserCellIndentifier", for: indexPath)
        let expString = self.transactionListDict![sectionsList?[indexPath.row] ?? ""] as!  String
        cell.textLabel?.text = self.sectionsList?[indexPath.row]
        cell.detailTextLabel?.text = expString

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sectionData = self.sectionsList {
            return sectionData.count
        } else {
            return 0
        }
    }
}
