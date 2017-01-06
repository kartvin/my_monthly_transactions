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
            
            // check for http errors
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json) // for debug
            } catch {
                print("error in JSON : \(error)")
            }
            completion(data as NSData)
        }
        task.resume()
    }
}
