//
//  VCDeals.swift
//  localLandings
//
//  Created by Jeff Frabell on 2/7/17.
//  Copyright © 2017 POR. All rights reserved.
//

import UIKit

class VCInstall: UIViewController {
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var textProgress: UILabel!

    let group = DispatchGroup()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        print("Install")
        progressBar.setProgress(0, animated: true)
        fillDB()
        group.notify(queue: .main) {
            self.goToLogin()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillDB(){
        var data = self.readDataFromCSV(fileName: "ap", fileType: "tsv")
        data = self.cleanRows(file: data!)
        let csvRows = self.csv(data: data!)
        let numberOfRows = csvRows.count

        group.enter()
        DispatchQueue.global(qos: .utility).async {
            if(utilityUserDB.shared.createAirportTable()){
            for i in 0 ..< numberOfRows {
                
                // do something time consuming here
                
                    print(i)
                    let name = csvRows[i][0]
                    let three = csvRows[i][1]
                    let four = csvRows[i][2]
                    let lat = csvRows[i][3]
                    let lon = csvRows[i][4]
                    
                    //this is working, now put it in a database.
                    if(utilityUserDB.shared.insertAirport(name: name, three: three, four: four, lat: lat, lon: lon)){
                        print("Inserting " + name)
                    } //end if insert user

                    
                self.group.enter()
                DispatchQueue.main.async {
                    // now update UI on main thread
                    let intprogressnumber = Int(floor(((Float(i) / Float(numberOfRows))*100)))
                    let toShow = String(intprogressnumber)
                    self.progressBar.setProgress(Float(i) / Float(numberOfRows), animated: true)
                    self.textProgress.text = toShow + "% complete"
                    self.group.leave()
                }  //end second async
                
            }//end iterator loop
                
            }//end create database
            self.group.leave()
        }//end of block of async
        

        
         }   //end function
    
    
    
    
    
    func readDataFromCSV(fileName:String, fileType: String)-> String!{
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }
    
    
    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }
    
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: "\t")
            result.append(columns)
        }
        return result
    }
    
    
    func goToLogin(){
        let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "loginScene")
        self.show(vc as! UIViewController, sender: vc)

    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
