//
//  DealsPostRequest.swift
//  localLandings
//
//  Created by Jeff Frabell on 7/25/17.
//  Copyright © 2017 POR. All rights reserved.
//

import Foundation

class DealsPostRequest{
    
    func dealsPostRequest(VCDeals: VCDeals, city: String){
        
        // Show MBProgressHUD Here
        var config                              :URLSessionConfiguration!
        var urlSession                          :URLSession!
        var mutableCity = city
        
        config = URLSessionConfiguration.default
        urlSession = URLSession(configuration: config)
        
        // MARK:- HeaderField
        let HTTPHeaderField_ContentType         = "Content-Type"
        
        // MARK:- ContentType
        let ContentType_ApplicationJson         = "application/json"
        
        //MARK: HTTPMethod
        let HTTPMethod_Get                      = "POST"
        
        if mutableCity=="No checkins yet"{
        mutableCity = "KFLL"
        }
        let callURL = URL.init(string: "http://ll.bunnyhutt.com/getlocaldeal.php?city=\(mutableCity)")
        
        var listOfDeals = ["Yo","Momma","so","fat"]
        listOfDeals.removeAll()
        
        var request = URLRequest.init(url: callURL!)
        
        request.timeoutInterval = 60.0 // TimeoutInterval in Second
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.addValue(ContentType_ApplicationJson, forHTTPHeaderField: HTTPHeaderField_ContentType)
        request.httpMethod = HTTPMethod_Get
        
        
        let dataTask = urlSession.dataTask(with: request) { (data,response,error) in
            if error != nil{
                return
            }
            do {
                
                let resultJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                
                
                let city = resultJson?["city"] as! String
                
                let loopCount = (resultJson?.count)! - 3
                
                for i in 0...loopCount {
                    listOfDeals.append(resultJson?["deal\(i)"] as! String)
                }

                print (city)
                
                
                
                
                var sendIt : [String] = listOfDeals
                print(sendIt)
                
                VCDeals.notify(sendIt: &sendIt);

                
                
                
                //VCFriends.notify(sendIt: &sendIt);
            } catch {
                print("Error -> \(error)")
            }

            
                
                
                
                
                
                //VCDeals.notify(sendIt: &sendIt);
            }  //closes dataTask
        
        dataTask.resume()
        
    } //closes function / do
        
}  //closes class

   
