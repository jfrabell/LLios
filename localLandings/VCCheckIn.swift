//
//  Friends.swift
//  localLandings
//
//  Created by Jeff Frabell on 2/7/17.
//  Copyright © 2017 POR. All rights reserved.
//

import UIKit

class VCCheckIn: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var picker_airports: UIPickerView!
    @IBOutlet weak var text_search: UITextField!
    var decimalDigit = ["Searching for Nearby Airports"," "," "," "]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
        self.picker_airports.delegate = self
        self.picker_airports.dataSource = self
        
        //let fish = utilityUserDB.shared.getAirportsWithinTen(lat: "40.0000", lon: "-83.0000")
        let fish = utilityUserDB.shared.getAirportsWithinTen(lat: "35.0000", lon: "-83.0000")
        
        let airport_split = buildAirportList(fish: fish)
        decimalDigit = airport_split
        
          }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btn_search_click(_ sender: Any) {
        let searchedText = text_search.text
        print(searchedText as Any)
    }
    
    //MARK:- PickerView Delegate & DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return decimalDigit.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return decimalDigit[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.text_search.text = decimalDigit[row]
    }
    
    
    func buildAirportList(fish : [String]) -> [String]{
        
        var returner = ["0","1"]

        let end = fish.count-1
        
        returner.removeAll()
        
        for i in 0...end {
            let thisAirportString = fish[i]
            let thisAirportArray = thisAirportString.components(separatedBy: "|")
            let theFinalAnswer = thisAirportArray[1] + " - " + thisAirportArray[2]
            returner.append(theFinalAnswer)
                print(fish[i])
        }
        
        return returner
    }
    
    
    
}


