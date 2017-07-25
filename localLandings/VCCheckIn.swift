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
        
        let temp = utilityUserDB.shared.getMyLatLon()
        
        let tempArray = temp.components(separatedBy: "~")
        let lat = tempArray[0]
        let lon = tempArray[1]
        
        let listOfTenAirports = utilityUserDB.shared.getAirportsWithinTen(lat: lat, lon: lon)
        
        let airport_split = buildAirportList(listOfTenAirports: listOfTenAirports)
        decimalDigit = airport_split
        
          }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btn_search_click(_ sender: Any) {
        let searchedText = text_search.text
        print(searchedText as Any)
        
        picker_airports.selectRow(0, inComponent: 0, animated: true)
        
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
        let alert = UIAlertController(title: "Check in at ", message: decimalDigit[row] + "?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: yesClicked))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    
    func buildAirportList(listOfTenAirports : [String]) -> [String]{
        
        var returner = ["0","1"]

        let end = listOfTenAirports.count-1
        
        returner.removeAll()
        
        for i in 0...end {
            let thisAirportString = listOfTenAirports[i]
            let thisAirportArray = thisAirportString.components(separatedBy: "|")
            let theFinalAnswer = thisAirportArray[1] + " - " + thisAirportArray[2]
            returner.append(theFinalAnswer)
        }
        
        return returner
    }
    
    func yesClicked(alert: UIAlertAction!) {
        let alert = UIAlertController(title: "YAY ", message: "It worked!!!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}


