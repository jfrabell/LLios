//
//  User.swift
//  localLandings
//
//  Created by Jeff Frabell on 7/5/17.
//  Copyright © 2017 POR. All rights reserved.
//

import UIKit

class User {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int

    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0  {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        
    }
    
}

