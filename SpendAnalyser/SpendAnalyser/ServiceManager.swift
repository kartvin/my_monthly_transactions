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
    var transactionList :  Array<TransactionVO>?
    
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

    public func getAllTransactions(completion: @escaping (_ result: Array<TransactionVO>) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        let urlString = self.urls?["GetAllTransactions"] as! String
        makeServiceCall(urlString: urlString, completion: { (transactions: Array<TransactionVO>) in
            self.transactionList = transactions
            completion(transactions)
        }, failure: failure)
    }
    
    public func getAllTransactionsForMonth(completion: @escaping (_ result: Array<TransactionVO>) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        
        let urlString = self.urls?["TransactionForMonth"] as! String
        makeServiceCall(urlString: urlString, completion: { (transactions: Array<TransactionVO>) in
            completion(transactions)
        }, failure: failure)
    }
    
    public func makeServiceCall(urlString:String, completion: @escaping (_ result: Array<TransactionVO>) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        if (!Reachability.isNetworkReachable()) {//Check for internet connection
            failure(NSError(domain: "No internet connection", code: 121, userInfo: nil))
            return
        }
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
            self.httpClient.makePostRequest(request: request, completion: { (jsonResponse : NSData) in
                do {
                    //convert data to AnyObject
                    let jsonObject: AnyObject? = try JSONSerialization.jsonObject(with: jsonResponse as Data, options: []) as AnyObject
                    let response = self.parseJsonForGetAllTransactions(response:jsonObject!)
                    
                    DispatchQueue.main.sync(execute: { () -> Void in
                        completion(response.transactions)
                    })
                }catch {
                    DispatchQueue.main.sync(execute: { () -> Void in
                        failure(NSError(domain: "Parsing Error", code: 121, userInfo: nil))
                    })
                }
            }, failure: { (error : NSError) in
                DispatchQueue.main.sync(execute: { () -> Void in
                    failure(error)//Throw general failures
                })
            })
        })
    }
    
    //This method will parse the json and save in TransactionVO
    //Only required fields are saved into the object
    private func parseJsonForGetAllTransactions (response:AnyObject) -> GetAllTransactionResponse{
        
        var transactions:Array<TransactionVO> = []
        let responseObject = GetAllTransactionResponse()
        
        if  response is NSDictionary {
            responseObject.error =  (response["error"] as AnyObject? as? String) ?? ""
            guard let transactionList = response["transactions"] else {
                return responseObject
            }
            for transactionItem in transactionList as! Array<AnyObject>{
                let merchant = (transactionItem["merchant"] as AnyObject? as? NSString) ?? ""
                
                //This is skip all donut related transactions from the list
                if merchant.lowercased.contains("donut") || merchant.lowercased.contains("dunkin")  {
                    continue
                }
                let transaction:TransactionVO = TransactionVO()
                transaction.merchant = merchant
                transaction.amount  =  (transactionItem["amount"]  as AnyObject? as? Int) ?? 0

                let transactionTime =  (transactionItem["transaction-time"] as AnyObject? as? NSString) ?? ""
                transaction.transactionTime = transactionTime
                if (transactionTime.length > 9) {
                    transaction.transactionDisplayTime = (transactionTime.substring(with: NSRange(location: 0, length: 10)) as NSString) as String
                    transaction.transactionDisplayMonth = (transactionTime.substring(with: NSRange(location: 0, length: 7)) as NSString) as String

                }
                
                transactions.append(transaction)
            }
            
            responseObject.transactions = transactions
        }
        return responseObject
    }
    
    //POST body JSON parameters
    private func getParams() -> NSDictionary {
        let params = ["uid" : 1110590645,
                      "token" : "1DE1AFADD0AFE46068857E0DD8C050B0",
                      "api-token" : "AppTokenForInterview",
                      "json-strict-mode" : false,
                      "json-verbose-response" :false] as [String : Any]
         as [String : Any]
        return ["args" : params,
                "year":2017,
                "month":1]
    
    }
}
