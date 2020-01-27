//
//  ViewController.swift
//  FoodTracker
//
//  Created by Jeff Frabell on 1/28/17.
//  Copyright © 2017 Jeff Frabell. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class VCMainScreen: UIViewController, UITextFieldDelegate, MKMapViewDelegate, CLLocationManagerDelegate, UIWebViewDelegate {
    
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var adWebView: UIWebView!
    
    //INCLUDE NSTimer to update location hourly?
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let anHourAgo = Date().timeIntervalSince1970 - (60*60)
        let lastLocationTime = utilityUserDB.shared.getLastLoginTime()
        if(lastLocationTime < anHourAgo){
        locationManager = CLLocationManager()
        initializeLocationManager(locationManager: locationManager)
        }
        else{
            print("No Need")
            let latLon = utilityUserDB.shared.getMyLatLon()
            let latLonList = latLon.components(separatedBy: "~")
            let latFinal = latLonList[0]
            let lonFinal = latLonList[1]
            updateMapOldData(latitude: latFinal, longitude: lonFinal)
        } //end else
        
        adWebView.loadRequest(URLRequest(url: URL(string: "http://ll.bunnyhutt.com/ads/CMH.html")!))
        
    } //end did load

//only get location if we haven't got one in the last hour...

    //Start the location manager
    func initializeLocationManager(locationManager: CLLocationManager){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // Get current location from location manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let latestLocation = locations.last
        let latitude = String(format: "%.4f", latestLocation!.coordinate.latitude)
        let longitude = String(format: "%.4f", latestLocation!.coordinate.longitude)
        
        utilityUserDB.shared.setLoginTime()
        let latLon = "\(latitude)~\(longitude)"
        
        updateMap(latitude: latitude, longitude: longitude)
        
        utilityUserDB.shared.setMyLatLon(newLatLon: latLon)

        manager.stopUpdatingLocation()
    }

    
    
    func updateMap(latitude: String, longitude: String){
        
        self.mapView.showsUserLocation = true
        self.mapView.userTrackingMode = .follow
        
    }
    
    func updateMapOldData(latitude: String, longitude: String){
        
        let newLat = Double(latitude)
        let newLon = Double(longitude)
        let myCoordinate = CLLocation(latitude: newLat!, longitude: newLon!)
        let regionRadius: CLLocationDistance = 5280
        
        let coordinateRegion = MKCoordinateRegion.init(center: myCoordinate.coordinate,
                                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        self.mapView.setRegion(coordinateRegion, animated: true)

    }
    
    
}
