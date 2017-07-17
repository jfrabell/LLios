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


class VCHome: UIViewController, UITextFieldDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
