//
//  TransactionListViewController.swift
//  SpendAnalyser
//
//  Created by Karthik Kumaravel on 1/5/17.
//  Copyright © 2017 Karthik Kumaravel. All rights reserved.
//

import UIKit

class TransactionListViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    fileprivate var transactionListDict: NSMutableDictionary?
    fileprivate var sectionsList: Array<String>?
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var toastLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loaderView.isHidden = false;
        //Makes service call and load the tableview on completion or throws an error on failure
        ServiceManager.sharedInstance.getAllTransactions(completion: {  (result : Array<TransactionVO>) in
            self.sortTransactions(transactions: result)
            self.loaderView.isHidden = true;
            self.tableView.reloadData()
        }) { (error : NSError) in
            self.toastLabel.text = error.localizedDescription
            self.spinner.stopAnimating()
            self.showErrorAlert(errorMessage: error.localizedDescription)
        }
    }
    
    //Sorts the transaction list based on displayTime (i.e)10-10-2016
    private func sortTransactions(transactions:  Array<TransactionVO>) {
        var transactionDates: [String]? = []
        self.transactionListDict = NSMutableDictionary()
        
        for transactionItem in transactions {
            transactionDates?.append(transactionItem.transactionDisplayTime as String)
        }
        self.sectionsList = Array(Set(transactionDates! as [String]))
        self.sectionsList = self.sectionsList?.sorted { $0 > $1 }

        for transactionDate in self.sectionsList! {
            let filteredArray = transactions.filter() { $0.transactionDisplayTime == transactionDate }
            self.transactionListDict?.setValue(filteredArray, forKey: transactionDate)
        }

    }
    
    //Set intersection
    func uniq<S : Sequence, T : Hashable>(source: S) -> [T] where S.Iterator.Element == T {
        var buffer = [T]()
        var added = Set<T>()
        for elem in source {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}

extension TransactionListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCellIndentifier", for: indexPath)
        let transactions = self.transactionListDict![sectionsList?[indexPath.section] as Any] as? [TransactionVO]
        guard transactions != nil else {
            return cell
        }
        
        let transaction = transactions?[indexPath.row]
        cell.textLabel?.text = transaction?.merchant as? String
        let amountStr = "$"
        cell.detailTextLabel?.text = amountStr.appending((transaction?.amount.stringFormattedWithComma)!)
        return cell
    }
    
    func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.sectionsList?[section] as String?
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sectionData = self.sectionsList {
            return sectionData.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let transactions = self.transactionListDict![sectionsList?[section] as Any] as? [TransactionVO]
        return transactions!.count
    }
    
}
