//
//  RestClient.swift
//  SpendAnalyser
//
//  Created by Karthik Kumaravel on 1/5/17.
//  Copyright © 2017 Karthik Kumaravel. All rights reserved.
//

import Foundation

class RestClient {    
    func makePostRequest(request: URLRequest, completion: @escaping (NSData)->Void, failure: @escaping (NSError)->Void) {
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else{
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            print(data as NSData) //<-`as NSData` is useful for debugging
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)
                //Why don't you use decoded JSON object? (`json` may not be a `String`)
            } catch {
                print("error serializing JSON: \(error)")
            }
            //Not sure what you mean with "i need to return the json as String"
//            let responseString = String(data: data, encoding: .utf8) ?? ""
            completion(data as NSData)
        }
        task.resume()
    }
}
