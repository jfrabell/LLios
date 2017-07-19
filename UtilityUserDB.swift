//
//  userDB.swift
//  localLandings
//
//  Created by Jeff Frabell on 7/5/17.
//  Copyright © 2017 POR. All rights reserved.
//

import UIKit

class utilityUserDB: NSObject {

    static let shared: utilityUserDB = utilityUserDB()
    
    let databaseFileName = "user.db"
    var pathToDatabase: String!
    var database: FMDatabase!
    
    let table_AIRPORTS = "AIRPORTS"
    
    let field_ID = "ID"
    let field_NAME = "NAME"
    let field_THREE = "THREE"
    let field_FOUR = "FOUR"
    let field_LAT = "LAT"
    let field_LON = "LON"
    
    
    
    let table_USER = "USER"
          let field_USERNAME = "USERNAME"
    let field_LOCATION = "LOCATION"
    let field_LOCATION_TIME = "LOCATION_TIME"
    let field_PRIVACY = "PRIVACY"
    
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    
    
    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        if database != nil {
            if database.open() {
                return true
            }
        }
        
        return false
    }

    
    func createAirportTable() -> Bool {
        var created = false

        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
            
            if database != nil {
                // Open the database.
                if database.open() {
                    let createMyTableQuery = "CREATE TABLE IF NOT EXISTS " + table_AIRPORTS + "("+field_ID+" INTEGER PRIMARY KEY AUTOINCREMENT, " + field_NAME + " TEXT, " + field_THREE +
                        " TEXT, " + field_FOUR + " TEXT, " + field_LAT + " TEXT, " + field_LON + ")"
                    
                    do {
                        try database.executeUpdate(createMyTableQuery, values: nil)
                        created = true
                    }
                    catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
                    
                    // At the end close the database.
                    database.close()
                }
                else {
                    print("Could not open the database.")
                }
            }
        }
        
        return created
    }
    
    
    func insertAirport(name: String,three: String,four: String,lat: String,lon: String)->Bool {
        if openDatabase() {
            let query:String = "INSERT INTO " + table_AIRPORTS + "(" + field_NAME + "," + field_THREE + "," + field_FOUR + "," + field_LAT + "," + field_LON + ") VALUES ('" + name + "','" + three + "','" + four + "','" + lat + "','" + lon + "')"
         
            if !database.executeStatements(query) {
                print("Failed to insert initial data into the database.")
                print(database.lastError(), database.lastErrorMessage())
            }
                    database.close()
        }
        return true;
    }
    
    
    
    func createUserTable() -> Bool {
        var created = false
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        self.pathToDatabase = documentsDirectory.appending("/user.db")

        
        if FileManager.default.fileExists(atPath: self.pathToDatabase) {
            database = FMDatabase(path: self.pathToDatabase!)
            
            if database != nil {
                // Open the database.
                if database.open() {
                    let createMyTableQuery = "CREATE TABLE IF NOT EXISTS " + table_USER + "("+field_ID+" INTEGER PRIMARY KEY AUTOINCREMENT, " + field_USERNAME + " TEXT, " + field_LOCATION +
                        " TEXT, " + field_LOCATION_TIME + " TEXT, " + field_PRIVACY + " TEXT)"
                    
                    do {
                        try database.executeUpdate(createMyTableQuery, values: nil)
                        created = true
                    } // end do
                    catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }  // end catch
                    
                    // At the end close the database.
                    database.close()
                }  //end open database
                else {
                    print("Could not open the database.")
                }  //end couldn't open db
            } //end database not nil
        } //end file exists
        
        return created
    }
    
    
    func insertUser(username: String,location: String,location_time: String,privacy: String)->Bool {
        if openDatabase() {
            let query:String = "INSERT INTO " + table_USER + "(" + field_USERNAME + "," + field_LOCATION + "," + field_LOCATION_TIME + "," + field_PRIVACY + ") VALUES ('" + username + "','" + location + "','" + location_time + "','" + privacy + "')"
            
            if !database.executeStatements(query) {
                print("Failed to insert user.")
                print(database.lastError(), database.lastErrorMessage())
            }
            database.close()
        }
        return true;
    }
    
    func updateUser(username: String,location: String)->Bool {
        if openDatabase() {
            
            let location_time = String(Date().timeIntervalSince1970)
            
            var query:String = "UPDATE " + table_USER + " SET `" + field_LOCATION + "` = '" + location
            query +=  "', `" + field_LOCATION_TIME + "` = '" + location_time
            query += "' WHERE `" + field_USERNAME + "' = '" + username + "' LIMIT 1"
            
            if !database.executeStatements(query) {
                print("Failed to insert initial data into the database.")
                print(database.lastError(), database.lastErrorMessage())
            }
            database.close()
        }
        return true;
    }
    
    func updateUser(username: String, privacy: String)->Bool {
        if openDatabase() {
            let query:String = "UPDATE " + table_USER + " SET `" + field_PRIVACY + "` = '" + privacy + "' WHERE `" + field_USERNAME + "' = '" + username + "' LIMIT 1"
            
            if !database.executeStatements(query) {
                print("Failed to insert initial data into the database.")
                print(database.lastError(), database.lastErrorMessage())
            }
            database.close()
        }
        return true;
    }
    
    func isLoggedIn()->Bool{
        var returner = false
        if openDatabase() {
            let query:String = "SELECT * FROM " + table_USER
            
            do {
                let results = try database.executeQuery(query, values: nil)
                print(results.columnCount)
                returner = true
            }
            catch {
                print(error.localizedDescription)
                returner = false
            }
            database.close()
        }
        return returner;
    }
    
    func logMeOut()->Bool{
        var returner = false
        if openDatabase(){
            let query:String = "DROP TABLE " + table_USER
            if database.executeStatements(query) {
                returner = true
            }
            else{                      //query failed
                print ("The test db query failed for some reason")
                returner = false
            } //end else
        } //end open database
        return returner
        }
    
    func testDb() -> Bool{
        var returner = false
        if openDatabase(){
            let query:String = "SELECT * FROM " + table_AIRPORTS
            if database.executeStatements(query) {
                returner = true
            }
            else{                      //query failed
                print ("The test db query failed for some reason")
                returner = false
            } //end else
        } //end open database
        else {
            returner = false           //database didn't open
        }
        return returner
    } // end func
    
    }