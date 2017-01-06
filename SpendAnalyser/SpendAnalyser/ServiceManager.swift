//
//  ServiceManager.swift
//  SpendAnalyser
//
//  Created by Karthik Kumaravel on 1/5/17.
//  Copyright © 2017 Karthik Kumaravel. All rights reserved.
//

import Foundation

class ServiceManager: NSObject {
    var transactions : NSMutableArray?
    private var urls: NSDictionary?
    private let httpClient: RestClient

    class var sharedInstance: ServiceManager {
        struct Singleton {
            static let instance = ServiceManager()
        }
        return Singleton.instance
    }

    override init() {
        httpClient = RestClient()
        if let path = Bundle.main.path(forResource: "Configuration", ofType: "plist") {
            urls = NSDictionary(contentsOfFile: path)
        }
        super.init()
    }

    public func getAllTransactions(completion: @escaping (_ result: String) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        if (!Reachability.isNetworkReachable()) {//Check for internet connection
            failure(NSError(domain: "No internet connection", code: 121, userInfo: nil))
            return
        }
        let urlString = self.urls?["GetAllTransactions"] as! String
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: { () -> Void in
            var request = URLRequest(url: URL(string: urlString)!)
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: self.getParams(), options: .prettyPrinted)
                request.httpBody = jsonData
            }
            catch {//Throw failure block incase of invalid params
                DispatchQueue.main.sync(execute: { () -> Void in
                    failure(NSError(domain: "Invalid parameters", code: 121, userInfo: nil))
                })
               return
            }
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
            request.httpMethod = "POST"
            self.httpClient.makePostRequest(request: request, completion: { (jsonResponse : String) in
                DispatchQueue.main.sync(execute: { () -> Void in
                    completion("SUCCESS!" + jsonResponse)
                })
            }, failure: { (error : NSError) in
                DispatchQueue.main.sync(execute: { () -> Void in
                    failure(error)//Throw general failures
                })
            })
        })
    }
    
    private func getParams() -> NSDictionary {
        let params = ["uid" : 1110590645,
                      "token" : "1DE1AFADD0AFE46068857E0DD8C050B0",
                      "api-token" : "AppTokenForInterview",
                      "json-strict-mode" : false,
                      "json-verbose-response" :false] as [String : Any]
         as [String : Any]
        return ["args" : params]
    
    }
}
