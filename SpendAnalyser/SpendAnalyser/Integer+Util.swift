//
//  Integer+Util.swift
//  SpendAnalyser
//
//  Created by Karthik Kumaravel on 1/6/17.
//  Copyright © 2017 Karthik Kumaravel. All rights reserved.
//

import UIKit

struct Number {
    static let formatterWithComma: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Integer {
    var stringFormattedWithComma: String {
        return Number.formatterWithComma.string(from: self as! NSNumber) ?? ""
    }
}

