//
//  Login.swift
//  localLandings
//
//  Created by Jeff Frabell on 6/15/17.
//  Copyright © 2017 POR. All rights reserved.
//

import UIKit

class VCLogin: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    let queue = DispatchQueue(label: "com.bunnyhutt.myqueue", qos: .utility)
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("Login")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Login
    @IBAction func click(_ sender: UIButton) {

        
        //verify username and password entered
        if(userName.text?.isEmpty)!{
            let alert = UIAlertController(title: "Alert", message: "Please enter a user name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if(passWord.text?.isEmpty)!{
            let alert = UIAlertController(title: "Alert", message: "Please enter a password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            
            
            
            
            //username and password entered.
            
            var returnData = "Start,"
            var request = URLRequest(url: URL(string: "https://ll.darattman.com/login.php")!)
            request.httpMethod = "POST"
            
            let userNameSubmitted = userName.text
            let passwordSubmitted = passWord.text
            let postString = "username=" + userNameSubmitted! + "&password=" + passwordSubmitted!
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    returnData += "Bad," + (String(describing: error))
                    self.processLogin(returnData: returnData)
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    returnData += "Bad," + (String(describing: response))
                    self.processLogin(returnData: returnData)
                }
                
                let responseString = String(data: data, encoding: .utf8)
                returnData += "Good," + (String(describing: responseString))
                self.processLogin(returnData: returnData)
            }
            
            task.resume()
        }
    }
    
    @IBAction func register(_ sender: UIButton) {
        let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "MainScreen")
        self.show(vc as! UIViewController, sender: vc)
    }
    
    func processLogin(returnData: String){

        var successOutput = "Something went horribly wrong"
        let returnDataArray = returnData.components(separatedBy: ",")
        let successArray = returnDataArray[2].components(separatedBy: ":")
        
        if(returnDataArray.count == 3){
            successOutput = "Invalid username or password"
        }
        else
        {
            //test needed because returnDataArray is different length depending on username entered
            let successReasonArray = returnDataArray[3].components(separatedBy: ",")
            let successReason = successReasonArray[0].components(separatedBy: "\\")
            //gets the reason for the failure or the name for success
            //returnDataArray 1 is good or bad, 2 is success or failure of login, 3 should be reason or name
            successOutput = successReason[3].replacingOccurrences(of: "\"", with: "")
            //reason for success or failure of login (excluding network errors)
        }
        
        
        if(returnDataArray[1] == "Good"){
            print("Network Success")
            print(returnDataArray[1])  //good or bad for network
        }
        else{
            DispatchQueue.main.async(execute: {
            let alert = UIAlertController(title: "Network Error", message: "Please verify access to the internet", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            })
        }
        
        if(successArray[1].contains("false")){
            DispatchQueue.main.async(execute: {

            let alert = UIAlertController(title: "Login Error", message: successOutput, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
                })
        }
        else{
            DispatchQueue.main.async(execute: {
                if(!utilityUserDB.shared.isLoggedIn()){
            if utilityUserDB.shared.createUserTable() {
                print("Created user table")
                if utilityUserDB.shared.insertUser(username: self.userName.text!, location: "No checkins yet", location_time: "0", privacy: "0") {
                    print("Inserted username")
                }
                    }
                }
                else{
                    print("Already logged in")
                }
            let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "mainScene")
            self.show(vc as! UIViewController, sender: vc)
                })
    }
    
}
}
