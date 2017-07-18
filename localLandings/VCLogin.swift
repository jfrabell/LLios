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
            let alert = UIAlertController(title: "Alert", message: "Please enter a user name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if(passWord.text?.isEmpty)!{
            let alert = UIAlertController(title: "Alert", message: "Please enter a password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            
            
            
            
            //username and password entered.
            
            queue.async {
                var returnData = "Start,"
                var request = URLRequest(url: URL(string: "http://ll.bunnyhutt.com/login.php")!)
                request.httpMethod = "POST"
                let postString = "username=jfrabell&password=chicken"
                request.httpBody = postString.data(using: .utf8)
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {                                                 // check for fundamental networking error
                        print("error=\(String(describing: error))")
                        returnData += "Bad," + (String(describing: error))
                        return
                    }
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print("response = \(String(describing: response))")
                        returnData += "Bad," + (String(describing: response))
                    }
                    
                    let responseString = String(data: data, encoding: .utf8)
                    print("responseString = \(String(describing: responseString))")
                    returnData += "Good," + (String(describing: responseString))
                }
                
                task.resume()
            }
            
            var returnData = "Start,"
            var request = URLRequest(url: URL(string: "http://ll.bunnyhutt.com/login.php")!)
            request.httpMethod = "POST"
            let postString = "username=jfrabell&password=chicken"
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    returnData += "Bad," + (String(describing: error))
                    self.commComplete(returnData: returnData)
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    returnData += "Bad," + (String(describing: response))
                    self.commComplete(returnData: returnData)
                }
                
                let responseString = String(data: data, encoding: .utf8)
                returnData += "Good," + (String(describing: responseString))
                self.commComplete(returnData: returnData)
            }
            
            task.resume()
                        
            
            
            
            let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "MainScreen")
            self.show(vc as! UIViewController, sender: vc)
        }
        

    }
    
    @IBAction func register(_ sender: UIButton) {
        let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "MainScreen")
        self.show(vc as! UIViewController, sender: vc)
    }
    
    func commComplete(returnData: String){
        print("We're Here")
        print(returnData)
        
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
