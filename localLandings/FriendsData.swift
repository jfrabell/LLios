//
//  IceCreamStore.swift
//  localLandings
//
//  Created by Jeff Frabell on 2/9/17.
//  Copyright © 2017 POR. All rights reserved.
//

import Foundation

class FriendsData
{
    var people = ["Loading Friends"]
    
     func changeData(myArray:[String]) -> [String]{
        people = myArray
        return self.people
    }
    
    func getPeople() -> [String]{
        return people
    }
    
     func clearAll(){
        people.removeAll(keepingCapacity: false)
    }
}
