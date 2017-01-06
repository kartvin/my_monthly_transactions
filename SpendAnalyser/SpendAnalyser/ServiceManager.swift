//
//  ServiceManager.swift
//  SpendAnalyser
//
//  Created by Karthik Kumaravel on 1/5/17.
//  Copyright © 2017 Karthik Kumaravel. All rights reserved.
//

import Foundation

class ServiceManager: NSObject {
    class var sharedInstance: ServiceManager {
        struct Singleton {
            static let instance = ServiceManager()
        }
        return Singleton.instance
    }
    
    public func getAllTransactions(input: String, completion: (_ result: String) -> Void) {
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: "Configuration", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        let urlString = myDict?["GetAllTransactions"] as! String
        let httpClient = RestClient()
        _ = httpClient.postRequest(urlString, body: urlString)
        completion("we finished!")
    }
}
