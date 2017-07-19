//
//  VCLogout.swift
//  localLandings
//
//  Created by Jeff on 7/19/17.
//  Copyright © 2017 POR. All rights reserved.
//

import UIKit

class VCLogout: UIViewController {
    @IBOutlet weak var BTN_logout: UIButton!
    
    override func viewDidLoad() {
                super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("Logout")
    }
    
    @IBAction func lougoutClick(_ sender: UIButton) {
        goToLogin()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToLogin(){
        if userDB.shared.logMeOut(){
            print("Logged out")
        }
        else{
            print ("Unable to log out for some reason")
        }
        DispatchQueue.main.async(execute: {
            let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "login")
            self.show(vc as! UIViewController, sender: vc)
        })

    }

    
}
