//
//  Friends.swift
//  localLandings
//
//  Created by Jeff Frabell on 2/7/17.
//  Copyright © 2017 POR. All rights reserved.
//

import UIKit

class VCCheckIn: UIViewController {
    
    var databasePath = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("Checkin")
       /*
        var databasePath = String()
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory,
                                    in: .userDomainMask)
        
        databasePath = dirPaths[0].appendingPathComponent("user.db").path
        
        if !filemgr.fileExists(atPath: databasePath as String) {
            
            let userDB = FMDatabase(path: databasePath as String)
          
            
            if (userDB.open()) {
                print("Database Open")
                let sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)"
                if !(userDB.executeStatements(sql_stmt)) {
                    print("Error: \(userDB.lastErrorMessage())")
                }
                userDB.close()
            } else {
                print("Error: \(userDB.lastErrorMessage())")
            }
            print("Completed Suckyly")
        }
        else
        {
        print("Database already created")
            let userDB = FMDatabase(path: databasePath as String)
            if (userDB.open()) {
                print("Database Open")
                let sql_stmt = "INSERT INTO CONTACTS (NAME,ADDRESS,PHONE) VALUES ('JOE','535','514')"
                if !(userDB.executeStatements(sql_stmt)) {
                    print("Error: \(userDB.lastErrorMessage())")
                }
            } else {
                print("Error: \(userDB.lastErrorMessage())")
            }
            print("Completed Suckyly")

            if(userDB.open()){
                let sql_stmtb = "SELECT * FROM CONTACTS"
                if !(userDB.executeStatements(sql_stmtb)){
                }
            }
            
            userDB.close()
            
            
        }
        
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
