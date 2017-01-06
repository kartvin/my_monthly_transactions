//
//  TransactionVO.swift
//  SpendAnalyser
//
//  Created by Karthik Kumaravel on 1/5/17.
//  Copyright © 2017 Karthik Kumaravel. All rights reserved.
//

import Foundation

class TransactionVO : NSObject {
    //Initialization with default values to avoid NPE
    var amount :Int = 0
    var merchant :NSString = ""
    var transactionTime :NSString = ""
    var transactionDisplayTime :String = ""
    var transactionDisplayMonth :String = ""

}
