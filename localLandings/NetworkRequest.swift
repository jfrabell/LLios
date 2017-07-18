//
//  NetworkRequest.swift
//  localLandings
//
//  Created by Jeff on 7/18/17.
//  Copyright © 2017 POR. All rights reserved.
//

import UIKit

class NetworkRequest: NSObject {
    static let shared: NetworkRequest = NetworkRequest()
    
    override init() {
        super.init()
        
            }

    func sendStuff() -> String{
        var returnData = "Start,"
        var request = URLRequest(url: URL(string: "http://ll.bunnyhutt.com/login.php")!)
        request.httpMethod = "POST"
        let postString = "username=jfrabell&password=chicken"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                returnData += "Bad," + (String(describing: error))
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                returnData += "Bad," + (String(describing: response))
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            returnData += "Good," + (String(describing: responseString))
        }
        
        task.resume()
        return returnData

    }
    
}
