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


class ViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    //INCLUDE NSTimer to update location hourly?
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        locationManager = CLLocationManager()
        initializeLocationManager(locationManager: locationManager)
        
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }
    
    
    //MARK: Actions
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "FUCK YEAH"
    }
    
    //Start the location manager
    func initializeLocationManager(locationManager: CLLocationManager){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // Get current location from location manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //self.locationManager.stopUpdatingLocation()
        let latestLocation = locations.last
        let latitude = String(format: "%.4f", latestLocation!.coordinate.latitude)
        let longitude = String(format: "%.4f", latestLocation!.coordinate.longitude)
        
        print("Latitude: \(latitude)")
        print("Longitude: \(longitude)")
        
        updateMap(latitude: latitude, longitude: longitude)
        manager.stopUpdatingLocation()
    }
    
    func updateMap(latitude: String, longitude: String){
        
        mealNameLabel.text = latitude + " / " + longitude
        self.mapView.showsUserLocation = true
        self.mapView.userTrackingMode = .follow
        
    }
    
}
