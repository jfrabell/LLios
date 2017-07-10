//
//  userDB.swift
//  localLandings
//
//  Created by Jeff Frabell on 7/5/17.
//  Copyright © 2017 POR. All rights reserved.
//

import UIKit

class userDB: NSObject {

    static let shared: userDB = userDB()
    
    let databaseFileName = "user.db"
    var pathToDatabase: String!
    var database: FMDatabase!
    
    let table_NAME = "CONTACTS"
    
    let field_ID = "ID"
    let field_NAME = "NAME"
    let field_ADDRESS = "ADDRESS"
    let field_PHONE = "PHONE"
    
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    
    func createDatabase() -> Bool {
        var created = false
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
            
            if database != nil {
                // Open the database.
                if database.open() {
                    let createMyTableQuery = "CREATE TABLE IF NOT EXISTS " + table_NAME + "("+field_ID+" INTEGER PRIMARY KEY AUTOINCREMENT, "+field_NAME+" TEXT, "+field_ADDRESS+" TEXT, "+field_PHONE+" TEXT)"
                    
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
    
    func insertUser(name: String,address: String,phone: String)->Bool {
        if openDatabase() {
            let query:String = "INSERT INTO " + databaseFileName + "("+field_NAME+","+field_ADDRESS+","+field_PHONE+") VALUES ('"+name+"','"+address+"','"+phone+"')"
         
            if !database.executeStatements(query) {
                print("Failed to insert initial data into the database.")
                print(database.lastError(), database.lastErrorMessage())
            }
                    database.close()
        }
        return true;
    }
    
}
