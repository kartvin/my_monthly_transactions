//
//  GetAllTransactionResponse.swift
//  SpendAnalyser
//
//  Created by Karthik Kumaravel on 1/6/17.
//  Copyright © 2017 Karthik Kumaravel. All rights reserved.
//

import Foundation

class GetAllTransactionResponse : NSObject {
    var error: String = ""
    var transactions: [TransactionVO] = []
}
