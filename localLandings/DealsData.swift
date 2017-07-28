//
//  DealsData.swift
//  localLandings
//
//  Created by Jeff Frabell on 7/27/17.
//  Copyright © 2017 POR. All rights reserved.
//

import Foundation

class DealsData
{
    var dealss = ["Loading Deals"]
    
    func changeData(myArray:[String]) -> [String]{
        dealss = myArray
        return self.dealss
    }
    
    func getDeals() -> [String]{
        return dealss
    }
    
    func clearAll(){
        dealss.removeAll(keepingCapacity: false)
    }
}
