//
//  UtilityClass.swift
//  localLandings
//
//  Created by Jeff Frabell on 2/9/17.
//  Copyright © 2017 POR. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class UtilityClass: NSObject {
    
    static let shared: UtilityClass = UtilityClass()

    override init() {
        super.init()
    }

    
    func getNearestTenAirports(location: CLLocation)->String{

        let coord1 = CLLocation(latitude: 52.12345, longitude: 13.54321)
        let coord2 = CLLocation(latitude: 52.45678, longitude: 13.98765)
        let coord3 = CLLocation(latitude: 53.45678, longitude: 13.54455)
        
        let coordinates = [coord1, coord2, coord3]
        
        let userLocation = CLLocation(latitude: 52.23678, longitude: 13.55555)
        
        let closest = coordinates.min(by:
        { $0.distance(from: userLocation) < $1.distance(from: userLocation) })
    
        print(String(describing: closest) + " is closest")
    return "Ten airports"
    }
    
    
    
    
    
    func locationInLocations(locations: Array<CLLocation>, closestToLocation location: CLLocation) -> CLLocation? {
        if locations.count == 0 {
            return nil
        }
        
        var closestLocation: CLLocation?
        var smallestDistance: CLLocationDistance?
        
        for location in locations {
            let distance = location.distance(from: location)
            if smallestDistance == nil || distance < smallestDistance! {
                closestLocation = location
                smallestDistance = distance
            }
        }
        
        print("closestLocation: \(String(describing: closestLocation)), distance: \(String(describing: smallestDistance))")
        return closestLocation
    }
    
}
