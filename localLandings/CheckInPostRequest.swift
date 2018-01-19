//
//  CheckInPostRequest.swift
//  localLandings
//
//  Created by Jeff Frabell on 8/15/17.
//  Copyright © 2017 POR. All rights reserved.
//

//
//  PostRequest.swift
//  localLandings
//
//  Created by Jeff Frabell on 2/9/17.
//  Copyright © 2017 POR. All rights reserved.
//

import Foundation

class CheckInPostRequest{
    
    func checkInPostRequest(VCCheckIn: VCCheckIn){
        
        // Show MBProgressHUD Here
        var config                              :URLSessionConfiguration!
        var urlSession                          :URLSession!
        
        config = URLSessionConfiguration.default
        urlSession = URLSession(configuration: config)
        
        // MARK:- HeaderField
        let HTTPHeaderField_ContentType         = "Content-Type"
        
        // MARK:- ContentType
        let ContentType_ApplicationJson         = "application/json"
        
        //MARK: HTTPMethod
        let HTTPMethod_Get                      = "POST"
        
        let callURL = URL.init(string: "http://ll.bunnyhutt.com/friendsb.php?username=jfrabell")
        
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
                
                
                let currentConditions = resultJson?["data"] as! [String:AnyObject]
                let list = currentConditions["checkins"] as! String
                var splitList = list.components(separatedBy: ",")
                var finishedList = [String]()
                
                print(splitList)
                //remove the non check in data from split list
                //finishedList = finishedList.filter(){$0 !=  "checked in at"}
                
                func filterContentForSearchText(searchText: String){
                    finishedList = splitList.filter { item in
                        return item.lowercased().contains(searchText.lowercased())
                    }
                }
                
                //var sendIt : [String] = filterContentForSearchText(searchText: "joey")
                splitList.remove(at: 0)
                
                var filtered = splitList.filter { (element) -> Bool in
                    return element != "checkin"
                }
                
                for i in (0...(filtered.count-1)).reversed() {
                    print(i)
                    if i % 2 == 0 {
                        print("\(i) is even number")
                    } else {
                        filtered.remove(at: i)
                    }
                }
                
                var sendIt : [String] = filtered
                print(sendIt)
                
                VCCheckIn.notify(sendIt: &sendIt);
            } catch {
                print("Error -> \(error)")
            }
        }  //closes dataTask
        
        dataTask.resume()
        
    } //closes function / do
    
}  //closes class
