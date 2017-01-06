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
    var transactionListDict: NSMutableDictionary?
    var sectionsList: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let arrayList = NSMutableArray()
        
        for _ in 1...10 {
            let transactionVO = TransactionVO()
            transactionVO.amount = 1321
            transactionVO.merchant = "Dunkin Donuts"
            transactionVO.transactionTime = "12/12/2006"
            
            arrayList.add(transactionVO);
        }
        
        self.transactionListDict = ["12/12/2006" : arrayList,
                                    "12/11/2006" : arrayList]
        
        self.sectionsList = ["12/12/2006", "12/11/2006"]
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCellIndentifier", for: indexPath)
        let transactions = self.transactionListDict![sectionsList![indexPath.section]] as? [TransactionVO]
        guard transactions != nil else {
            return cell
        }
        
        let transaction = transactions?[indexPath.row]
        cell.textLabel?.text = transaction?.merchant as? String
        cell.detailTextLabel?.text = String(describing: transaction?.amount)
        return cell
    }
    
    func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.sectionsList?[section] as! String?
        
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionsList!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let list = self.transactionListDict?[sectionsList?[section] ?? []] as! NSMutableArray
        return list.count
    }
}
